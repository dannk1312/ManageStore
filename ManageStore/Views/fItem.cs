using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ManageStore.Models;
using ManageStore.Controllers;
using System.Data.Entity.Core.Objects;


namespace ManageStore.Views
{
    public partial class fItem : Form
    {
        private BindingList<vw_Item> listItem;
        public vw_Item ItemModify;
        public List<string> AllCategory;
        public Item selectItem;
        private bool isBuying;
        private vw_Person member;
        public fItem(bool select = true,vw_Person input = null)
        {
            InitializeComponent();
            btnSelect.Visible = select;
            member = input;
            if (member != null)
            {
                btnAdd.Visible = btnEdit.Visible = false;
                txtName.MouseClick -= txtName_MouseClick;
            }
            isBuying = member != null;
        }

        private void LoadData()
        {
            listItem = new BindingList<vw_Item>(DataProvider.DB.vw_Item.ToList());
            var source = new BindingSource(listItem, null);
            dgvView.DataSource = source;

        }
        private void fItem_Load(object sender, EventArgs e)
        {
            LoadData();
            dgvView.CellClick += DgvView_CellClick;
            for (int i = 0; i < dgvView.Columns.Count; i++)
            {
                if (dgvView.Columns[i].Name.Contains("Id"))
                    dgvView.Columns[i].Visible = false;
                else
                {
                    cbColumnFilter.Items.Add(dgvView.Columns[i].Name);
                    if (dgvView.Columns[i].Name.Contains("Name"))
                        dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                    else dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                }
            }
            AllCategory = new List<string>();
            UnSelect();
        }

        private void DgvView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            SelectId(listItem[e.RowIndex].ItemId);
        }
        private void ItemModifyInfo()
        {
            txtName.Text = $"{ItemModify.ItemId}:[{ItemModify.Code}]{ItemModify.Name}({ItemModify.Enable}) (GIÁ: {ItemModify.Price}) (SL:{ItemModify.Quantity}) (Đơn Vị:{ItemModify.Unit}) (Thể Loại:{String.Join(",", AllCategory)}) ";
            lbId.Text = ItemModify.ItemId.ToString();
        }
        private void SelectId(int id)
        {
            for (int i = 0; i < listItem.Count; i++)
            {
                if (listItem[i].ItemId == id)
                {
                    dgvView.CurrentCell = dgvView[0, i];
                    ItemModify = new vw_Item()
                    {
                        ItemId = listItem[i].ItemId,
                        Name = listItem[i].Name,
                        Code = listItem[i].Code,
                        Price = listItem[i].Price,
                        Quantity = listItem[i].Quantity,
                        Unit = listItem[i].Unit,
                        UnitId = listItem[i].UnitId,
                        Enable = listItem[i].Enable,
                    };
                    AllCategory = (from run in DataProvider.DB.f_ItemCategory(ItemModify.ItemId) select run.CategoryId.ToString() + ":" + run.Name).ToList();     
                    ItemModifyInfo();
                }
            }
        }
        private void txtName_MouseClick(object sender, MouseEventArgs e)
        {
            using (var modify = new fItemModify(ItemModify))
            {
                modify.ShowDialog();
                if (modify.isChange)
                {
                    AllCategory = modify.AllCategory;
                    ItemModifyInfo();
                }
            }
        }

        private void UnSelect()
        {
            dgvView.CurrentCell = null;
            txtName.Text = "";
            lbId.Text = "None";

            ItemModify = new vw_Item()
            {
                ItemId = -1,
                Name = "",
                Code = "",
                Quantity = 0,
                Price = 0,
                UnitId = 0,
                Unit = "",
                Enable = true,
            };
        }

        //btn
        private void btnAdd_Click(object sender, EventArgs e)
        {
            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_InsertItem(ItemModify.Code, ItemModify.Name, ItemModify.Price, ItemModify.UnitId
                , String.Join(",",AllCategory.Select(x=>x.Split(':')[0])), ItemModify.Enable, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();
            if (lbMessage.Text.Contains("[S]"))
                lbId.Text = lbMessage.Text.Split(':')[1];
            if (lbId.Text != "None")
                SelectId(Convert.ToInt32(lbId.Text));
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (lbId.Text=="None")
                return;

            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_UpdateItem(ItemModify.ItemId, ItemModify.Code, ItemModify.Name, ItemModify.Price, ItemModify.UnitId
                 , String.Join(",", AllCategory.Select(x => x.Split(':')[0])), ItemModify.Enable, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();

            if (ckbFilter.Checked)
                FilterData(txtFilter.Text);
            if(lbId.Text!="None")
                SelectId(Convert.ToInt32(lbId.Text));
        }
        private void FilterData(string name)
        {
            dgvView.CurrentCell = null;
            switch (cbColumnFilter.Text)
            {
                case "Code":
                    for (int i = 0; i < listItem.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listItem[i].Code.Contains(name);
                    }
                    break;
                case "Name":
                    for (int i = 0; i < listItem.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listItem[i].Name.Contains(name);
                    }
                    break;
                case "Quantity":
                    for (int i = 0; i < listItem.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listItem[i].Quantity.ToString().Contains(name);
                    }
                    break;
                case "Unit":
                    for (int i = 0; i < listItem.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listItem[i].Unit.Contains(name);
                    }
                    break;
                case "Price":
                    for (int i = 0; i < listItem.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listItem[i].Price.ToString().Contains(name);
                    }
                    break;
            }
        }

        private void ckbFilter_CheckedChanged(object sender, EventArgs e)
        {
            cbColumnFilter.Visible = txtFilter.Visible = ckbFilter.Checked;
            txtFilter.Text = ckbFilter.Checked ? "" : "";
            FilterData(txtFilter.Text);
        }

        private void txtFilter_TextChanged(object sender, EventArgs e)
        {
            FilterData(txtFilter.Text);
        }

        private void btnSelect_Click(object sender, EventArgs e)
        {
            if (lbId.Text != "None")
            {
                int i = Convert.ToInt32(lbId.Text);
                if (isBuying == false)
                {
                    selectItem = DataProvider.DB.Item.Find(i);
                    this.Close();
                }
                else
                {
                    int? rs = DataProvider.DB.sp_AddToBag(member.PersonId, i).SingleOrDefault();
                    if (rs == 1)
                        lbMessage.Text = "[S]Thêm vào giỏ hàng ID: " + i.ToString() + " Thành Công";
                    else lbMessage.Text = "[F]Thêm thất bại";
                }                    
            }
            else
            {
                MessageBox.Show("Bạn chưa chọn gì cả, mời chọn 1 Item");
            }
        }
    }
}

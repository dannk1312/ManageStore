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
    public partial class fBill : Form
    {
        private BindingList<vw_Bill> listBill;
        private vw_Bill BillModify;
        private List<string> BillItemData;
        public fBill()
        {
            InitializeComponent();
        }

        private void LoadData()
        {
            listBill = new BindingList<vw_Bill>(DataProvider.DB.vw_Bill.ToList());
            var source = new BindingSource(listBill, null);
            dgvView.DataSource = source;

        }
        private void fBill_Load(object sender, EventArgs e)
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
                    if (dgvView.Columns[i].Name.Contains("Address"))
                        dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                    else dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                }
            }
            UnSelect();
            BillItemData = new List<string>();
        }

        private void DgvView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            SelectId(listBill[e.RowIndex].BillId);
        }
        private void BillModifyInfo()
        {
            txtName.Text = $"{BillModify.BillId}:{BillModify.Person} (Giá:{BillModify.TotalPrice} Bán:{BillModify.isCustomer} Hoàn Thành:{BillModify.isDone}) (Ngày:{BillModify.Date} TP:{BillModify.City} ĐC:{BillModify.Address}) (Đơn:{String.Join(",", BillItemData)})";
            lbId.Text = BillModify.BillId.ToString();
        }
        private void SelectId(int id)
        {
            for (int i = 0; i < listBill.Count; i++)
            {
                if (listBill[i].BillId == id)
                {
                    dgvView.CurrentCell = dgvView[0, i];
                    BillModify = new vw_Bill()
                    {
                        BillId = listBill[i].BillId,
                        Date = listBill[i].Date,
                        City = listBill[i].City,
                        Address = listBill[i].Address,
                        isCustomer = listBill[i].isCustomer,
                        isDone = listBill[i].isDone,
                        Person = listBill[i].Person,
                        CityId = listBill[i].CityId,
                        PersonId = listBill[i].PersonId,
                        TotalPrice = listBill[i].TotalPrice,
                    };
                    BillItemData = (from run in DataProvider.DB.f_BillItem(BillModify.BillId) select run.ItemId.ToString()+":["+run.Code+"]"+run.Name+":"+run.Quantity.ToString()).ToList();
                    BillModifyInfo();
                }
            }
        }
        private void txtName_MouseClick(object sender, MouseEventArgs e)
        {
            using (var modify = new fBillModify(BillModify))
            {
                modify.ShowDialog();
                if (modify.isChange)
                {
                    BillItemData = modify.BillItemData;
                    BillModifyInfo();
                }
            }
        }

        private void UnSelect()
        {
            dgvView.CurrentCell = null;
            txtName.Text = "";
            lbId.Text = "None";

            BillModify = new vw_Bill()
            {
                BillId = 0,
                Date = DateTime.Now,
                Address = "",
                isCustomer = true,
                isDone = false,
                PersonId = 0,
                CityId = 0,
            };
        }

        //btn
        private void btnAdd_Click(object sender, EventArgs e)
        {
            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_InsertBill(BillModify.Date, BillModify.PersonId, BillModify.TotalPrice, BillModify.CityId,
                BillModify.Address, BillModify.isCustomer, BillModify.isDone, String.Join(";", BillItemData.Select(x => x.Split(':')[0]+","+ x.Split(':')[2])), mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();
            if (lbMessage.Text.Contains("[S]"))
                lbId.Text = lbMessage.Text.Split(':')[1];
            if(lbId.Text!="None")
                SelectId(Convert.ToInt32(lbId.Text));
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (lbId.Text == "None")
                return;

            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_UpdateBill(BillModify.BillId,BillModify.Date, BillModify.PersonId, BillModify.TotalPrice, BillModify.CityId,
                BillModify.Address, BillModify.isCustomer, BillModify.isDone, String.Join(";", BillItemData.Select(x => x.Split(':')[0] + "," + x.Split(':')[2])), mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();

            if (ckbFilter.Checked)
                FilterData(txtFilter.Text);

            SelectId(Convert.ToInt32(lbId.Text));
        }
        private void FilterData(string name)
        {
            dgvView.CurrentCell = null;
            switch(cbColumnFilter.Text)
            {
                case "Person":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].Person.Contains(name);
                    }
                    break;
                case "Date":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].Date.ToString("dd/MM/yyyy").Contains(name);
                    }
                    break;
                case "City":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].City.Contains(name);
                    }
                    break;
                case "Address":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].Address.Contains(name);
                    }
                    break;
                case "TotalPrice":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].TotalPrice.ToString().Contains(name);
                    }
                    break;
                case "isCustomer":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].isCustomer.ToString().Contains(name);
                    }
                    break;
                case "isDone":
                    for (int i = 0; i < listBill.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listBill[i].isDone.ToString().Contains(name);
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


    }
}

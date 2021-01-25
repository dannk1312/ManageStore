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
    public partial class fCity : Form
    {
        private BindingList<vw_City> listCity;
        private bool sortAscending = false;
        public City selectCity;

        public fCity(bool select = false)
        {
            InitializeComponent();
            btnSelect.Visible = select;
        }

        private void LoadData()
        {
            listCity = new BindingList<vw_City>(DataProvider.DB.vw_City.ToList());
            var source = new BindingSource(listCity, null);
            dgvView.DataSource = source;

        }
        private void fCity_Load(object sender, EventArgs e)
        {
            LoadData();
            dgvView.CellClick += DgvView_CellClick;
            for (int i = 0; i < dgvView.Columns.Count; i++)
            {
                if (dgvView.Columns[i].Name.Contains("Id"))
                    dgvView.Columns[i].Visible = false;
                else if (dgvView.Columns[i].Name.Contains("Quantity"))
                    dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
                else dgvView.Columns[i].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            }
        }

        private void DgvView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            txtName.Text = listCity[e.RowIndex].Name;
            lbId.Text = listCity[e.RowIndex].CityId.ToString();
        }

        private void SelectId(int id)
        {
            for (int i = 0; i < listCity.Count; i++)
            {
                if (listCity[i].CityId == id)
                {
                    dgvView.CurrentCell = dgvView[0, i];
                }
            }
        }

        private void UnSelect()
        {
            dgvView.CurrentCell = null;
            txtName.Text = "";
            lbId.Text = "None";
        }

        //btn
        private void btnAdd_Click(object sender, EventArgs e)
        {
            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_InsertCity(txtName.Text, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();
            if (lbMessage.Text.Contains("[S]"))
                lbId.Text = lbMessage.Text.Split(':')[1];
            SelectId(Convert.ToInt32(lbId.Text));
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (dgvView.SelectedRows[0].Index > listCity.Count)
                return;

            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_UpdateCity(listCity[dgvView.SelectedRows[0].Index].CityId, txtName.Text, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();

            if (ckbFilter.Checked)
                FilterData(txtFilter.Text);

            SelectId(Convert.ToInt32(lbId.Text));
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (dgvView.SelectedRows[0].Index > listCity.Count)
                return;

            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_DeleteCity(listCity[dgvView.SelectedRows[0].Index].CityId, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();

            if (ckbFilter.Checked)
                FilterData(txtFilter.Text);

            if (lbMessage.Text.Contains("[S]"))
                UnSelect();
            else
                SelectId(Convert.ToInt32(lbId.Text));
        }

        private void FilterData(string name)
        {
            dgvView.CurrentCell = null;
            for (int i = 0; i < listCity.Count; i++)
            {
                dgvView.Rows[i].Visible = listCity[i].Name.Contains(name);
            }
        }

        private void ckbFilter_CheckedChanged(object sender, EventArgs e)
        {
            txtFilter.Visible = ckbFilter.Checked;
            txtFilter.Text = ckbFilter.Checked ? "" : "";
            FilterData(txtFilter.Text);
        }

        private void txtFilter_TextChanged(object sender, EventArgs e)
        {
            FilterData(txtFilter.Text);
        }

        private void dgvView_ColumnHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (sortAscending)
                dgvView.DataSource = listCity.OrderBy(x=>x.Name).ToList();
            else
                dgvView.DataSource = listCity.OrderBy(x => x.Name).Reverse().ToList();
            sortAscending = !sortAscending;
        }

        private void btnSelect_Click(object sender, EventArgs e)
        {
            if (lbId.Text != "None")
            {
                int i = Convert.ToInt32(lbId.Text);
                selectCity = DataProvider.DB.City.Find(i);
                this.Close();
            } 
            else
            {
                MessageBox.Show("Bạn chưa chọn gì cả, mời chọn 1 City");
            }                
        }
    }
}

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
    public partial class fPerson : Form
    {
        private BindingList<vw_Person> listPerson;
        private vw_Person personModify;
        public Person selectPerson;
        public fPerson(bool select = false)
        {
            InitializeComponent();
            btnSelect.Visible = select;
        }

        private void LoadData()
        {
            listPerson = new BindingList<vw_Person>(DataProvider.DB.vw_Person.ToList());
            var source = new BindingSource(listPerson, null);
            dgvView.DataSource = source;

        }
        private void fPerson_Load(object sender, EventArgs e)
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
        }

        private void DgvView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
                return;

            SelectId(listPerson[e.RowIndex].PersonId);
        }

        private void PersonModifyInfo()
        {
            txtName.Text = $"{personModify.PersonId}:{personModify.Name}({personModify.Role})  (SĐT: {personModify.Phone} Email:{personModify.Email}) (TP: {personModify.City} ĐC:{personModify.Address})";
            lbId.Text = personModify.PersonId.ToString();
        }
        private void SelectId(int id)
        {
            for (int i = 0; i < listPerson.Count; i++)
            {
                if (listPerson[i].PersonId == id)
                {
                    dgvView.CurrentCell = dgvView[0, i];
                    personModify = new vw_Person()
                    {
                        PersonId = listPerson[i].PersonId,
                        Name = listPerson[i].Name,
                        Phone = listPerson[i].Phone,
                        Email = listPerson[i].Email,
                        Address = listPerson[i].Address,
                        Password = listPerson[i].Password,
                        CityId = listPerson[i].CityId,
                        RoleId = listPerson[i].RoleId,
                        City = listPerson[i].City,
                        Role = listPerson[i].Role,
                    };
                    PersonModifyInfo();
                }
            }
        }
        private void txtName_MouseClick(object sender, MouseEventArgs e)
        {
            using (var modify = new fPersonModify(personModify))
            {
                modify.ShowDialog();
                if(modify.isChange)
                    PersonModifyInfo();
            }
        }

        private void UnSelect()
        {
            dgvView.CurrentCell = null;
            txtName.Text = "";
            lbId.Text = "None";

            personModify = new vw_Person()
            {
                PersonId = -1,
                Name = "",
                Phone = "",
                Email = "",
                Address = "",
                Password = "",
                CityId = 0,
                RoleId = 0,
            };
        }

        //btn
        private void btnAdd_Click(object sender, EventArgs e)
        {
            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_InsertPerson(personModify.Name, personModify.Phone, personModify.Email, personModify.Address,
                personModify.CityId, personModify.Password, personModify.RoleId, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();
            if (lbMessage.Text.Contains("[S]"))
                lbId.Text = lbMessage.Text.Split(':')[1];
            if(lbId.Text != "None")
                SelectId(Convert.ToInt32(lbId.Text));
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (lbId.Text == "None")
                return;

            ObjectParameter mess = new ObjectParameter("Message", "");
            DataProvider.DB.sp_UpdatePerson(personModify.PersonId, personModify.Name, personModify.Phone, personModify.Email, personModify.Address,
                personModify.CityId, personModify.Password, personModify.RoleId, mess);
            lbMessage.Text = mess.Value.ToString();
            DataProvider.ReloadData();
            LoadData();

            if (ckbFilter.Checked)
                FilterData(txtFilter.Text);
            if (lbId.Text != "None")
                SelectId(Convert.ToInt32(lbId.Text));
        }
        private void FilterData(string name)
        {
            dgvView.CurrentCell = null;
            switch(cbColumnFilter.Text)
            {
                case "Name":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].Name.Contains(name);
                    }
                    break;
                case "Phone":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].Phone.Contains(name);
                    }
                    break;
                case "Email":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].Email.Contains(name);
                    }
                    break;
                case "Address":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].Address.Contains(name);
                    }
                    break;
                case "City":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].City.Contains(name);
                    }
                    break;
                case "Password":
                    for (int i = 0; i < listPerson.Count; i++)
                    {
                        dgvView.Rows[i].Visible = listPerson[i].Password.Contains(name);
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
                selectPerson = DataProvider.DB.Person.Find(i);
                this.Close();
            }
            else
            {
                MessageBox.Show("Bạn chưa chọn gì cả, mời chọn 1 Person");
            }
        }
    }
}

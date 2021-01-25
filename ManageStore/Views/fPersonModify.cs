using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core.Objects;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ManageStore.Controllers;
using ManageStore.Models;

namespace ManageStore.Views
{
    public partial class fPersonModify : Form
    {
        public vw_Person person;
        public bool isChange = false;
        private bool normal = false;
        private bool signUp = false;
        public fPersonModify(vw_Person input, bool normal = false)
        {
            InitializeComponent();
            this.normal = normal;

            cbRole.DisplayMember = "Name";
            cbRole.ValueMember = "RoleId";
            cbRole.DataSource = (from run in DataProvider.DB.PersonRole
                                 select run).ToList();

            person = input;
            btnReset_Click(person, new EventArgs());
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            person.Name = txtName.Text;
            person.Phone = txtPhone.Text;
            person.Email = txtEmail.Text;
            person.Address = txtAddress.Text;
            person.RoleId = (int)cbRole.SelectedValue;
            person.Role = cbRole.Text;

            if (normal == false)
            {
                person.Password = txtPassword.Text;
            }

            if (txtCity.Text != "None")
            {
                person.CityId = Convert.ToInt32(txtCity.Text.Split(':')[0]);
                person.City = txtCity.Text.Split(':')[1];
            }
            if (signUp)
            {
                ObjectParameter mess = new ObjectParameter("Message", "");
                DataProvider.DB.sp_InsertPerson(person.Name, person.Phone, person.Email, person.Address,
                    person.CityId, person.Password, person.RoleId, mess);
                if (mess.Value.ToString().Contains("[S]") == false)
                {
                    MessageBox.Show(mess.Value.ToString());
                    return;
                }
            }

            isChange = true;
            this.Close();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            if (person == null)
            {
                person = new vw_Person() { RoleId = 3 ,CityId=0};
                cbRole.Enabled = false;
                signUp = true;
            }
            if (normal == true)
            {
                cbRole.Enabled = false;
                btnPassword.Visible = true;
                btnPassword.Text = "Verify";
            }
            else
            {
                txtPassword.Text = person.Password;
            }

            txtName.Text = person.Name;
            txtPhone.Text = person.Phone;
            txtEmail.Text = person.Email;
            txtAddress.Text = person.Address;
            txtCity.Text = person.CityId.ToString() + ':' + person.City;


            for (int i = cbRole.Items.Count - 1; i >= 0; i--)
            {
                cbRole.SelectedIndex = i;
                if ((int)cbRole.SelectedValue == person.RoleId)
                {
                    break;
                }
            }

        }

        private void btnCancelPassword_Click(object sender, EventArgs e)
        {
            if (normal == false)
                txtPassword.Text = person.Password;
            else
            {
                txtPassword.Text = "";
                btnPassword.Text = "Verify";
                btnPassword.Enabled = true;
            }
        }

        private void txtCity_Click(object sender, EventArgs e)
        {
            using (var f = new fCity(select: true))
            {
                f.ShowDialog();
                if (f.selectCity != null)
                    txtCity.Text = f.selectCity.CityId.ToString() + ":" + f.selectCity.Name;
            }
        }

        private void btnPassword_Click(object sender, EventArgs e)
        {
            if (btnPassword.Text == "Verify")
            {
                if (txtPassword.Text == person.Password)
                {
                    btnPassword.Text = "New";

                }
                txtPassword.Text = "";
            }
            else if (btnPassword.Text == "New")
            {
                person.Password = btnPassword.Text;
                btnPassword.Text = "DONE";
                btnPassword.Enabled = false;
            }
        }
    }
}

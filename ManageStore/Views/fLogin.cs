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
    public partial class fLogin : Form
    {
        public vw_Person person;
        public fLogin(vw_Person input)
        {
            InitializeComponent();
            person = input;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            int? id = DataProvider.DB.sp_Login(txtPOE.Text, txtPass.Text).SingleOrDefault();
            if (id>0)
            {
                person = DataProvider.DB.vw_Person.Where(x=>x.PersonId == id).SingleOrDefault();
                MessageBox.Show("[S]Đăng Nhập Thành Công.");
                this.Close();
            }
            else
            {
                txtPOE.Text = txtPass.Text = "";
                lbFail.Visible = true;

            }
        }

        private void txtPOE_Enter(object sender, EventArgs e)
        {
            lbFail.Visible = false;
        }

        private void txtPass_TextChanged(object sender, EventArgs e)
        {
            lbFail.Visible = false;

        }
    }
}

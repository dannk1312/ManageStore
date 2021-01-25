using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ManageStore.Controllers;
using ManageStore.Models;

namespace ManageStore.Views
{
    public partial class fMain : Form
    {
        private vw_Person Account;
        public fMain()
        {
            InitializeComponent();
        }

        private void unitTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fUnit())
            {
                f.ShowDialog();
            }    
        }

        private void categoryTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fCategory())
            {
                f.ShowDialog();
            }
        }

        private void cityTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fCity())
            {
                f.ShowDialog();
            }
        }

        private void reloadDataToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Reload();
        }

        private void personsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fPerson())
            {
                f.ShowDialog();
            }
        }

        private void Reload()
        {
            DataProvider.ReloadData();
            if(Account == null)
            {
                storeToolStripMenuItem.Visible = false;
                reloadDataToolStripMenuItem.Visible = false;
                menuStrip2.Visible = false;
                pnInformation.Visible = false;
                logOutToolStripMenuItem.Visible = false;
                informationToolStripMenuItem.Visible = false;
                loginToolStripMenuItem.Visible = true;
                signUpToolStripMenuItem.Visible = true;
                bagToolStripMenuItem1.Visible = false;
            }    
            else if (Account.Role == "ADMIN" || Account.Role == "MANAGER")
            {
                reloadDataToolStripMenuItem.Visible = true;
                logOutToolStripMenuItem.Visible = true;
                informationToolStripMenuItem.Visible = true;
                loginToolStripMenuItem.Visible = false;
                signUpToolStripMenuItem.Visible = false;
                storeToolStripMenuItem.Visible = false;
                menuStrip2.Visible = true;
                pnInformation.Visible = true;
                lbEnableItem.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_ItemEnableCount()").Single().ToString();
                lbUnableItem.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_ItemUnableCount()").Single().ToString();
                lbUnit.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_UnitCount()").Single().ToString();
                lbCategory.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_CategoryCount()").Single().ToString();

                lbEarnBill.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_EarnBillCount()").Single().ToString();
                lbPaidBill.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_PaidBillCount()").Single().ToString();
                lbEarnMoney.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_EarnMoney()").Single().ToString();
                lbPaidMoney.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_PaidMoney()").Single().ToString();

                lbAdmin.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_AdminCount()").Single().ToString();
                lbManager.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_ManagerCount()").Single().ToString();
                lbMember.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_MemberCount()").Single().ToString();
                lbBlock.Text = DataProvider.DB.Database.SqlQuery<int>("Select dbo.f_BlockCount()").Single().ToString();
            }
            else if (Account.Role == "MEMBER")
            {
               
                reloadDataToolStripMenuItem.Visible = true;
                logOutToolStripMenuItem.Visible = true;
                informationToolStripMenuItem.Visible = true;
                loginToolStripMenuItem.Visible = false;
                signUpToolStripMenuItem.Visible = false;
                menuStrip2.Visible = false;
                pnInformation.Visible = false;
                bagToolStripMenuItem1.Visible = true;
                storeToolStripMenuItem.Visible = true;
            }
        }
        private void fMain_Load(object sender, EventArgs e)
        {
            Reload();
        }

        private void billsTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fBill())
            {
                f.ShowDialog();
            }
        }

        private void itemsTableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            DataProvider.ReloadData();
            using (var f = new fItem())
            {
                f.ShowDialog();
            }
        }

        private void btnItemView_Click(object sender, EventArgs e)
        {
            itemsTableToolStripMenuItem_Click(sender, e);
        }

        private void btnBillView_Click(object sender, EventArgs e)
        {
            billsTableToolStripMenuItem_Click(sender, e);
        }

        private void btnPersonView_Click(object sender, EventArgs e)
        {
            personsToolStripMenuItem_Click(sender, e);
        }

        private void loginToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using(var f = new fLogin(Account))
            {
                f.ShowDialog();
                Account = f.person;
                Reload();
            }    
        }

        private void logOutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Account = null;
            Reload();
        }

        private void informationToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using(var f = new fPersonModify(Account,normal:true))
            {
                f.ShowDialog();
            }    

        }
        private void signUpToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var f = new fPersonModify(Account))
            {
                f.ShowDialog();
                if(f.isChange)
                {
                    Account = f.person;
                    Reload();
                }    
            }
        }

        private void storeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            using (var f = new fItem(input:Account))
            {
                f.ShowDialog();
            }
        }

        private void bagToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            int BillId = 0;
            Bill temp = DataProvider.DB.f_Bag(Account.PersonId).FirstOrDefault();
            while (temp == null)
            {
                DataProvider.DB.sp_CreateBag(Account.PersonId);
                DataProvider.ReloadData();
                temp = DataProvider.DB.f_Bag(Account.PersonId).FirstOrDefault();
            }
            BillId = temp.BillId;
            vw_Bill userBag = DataProvider.DB.vw_Bill.Where(x => x.BillId == BillId).FirstOrDefault();
            using (var f = new fBillModify(userBag, person: Account))
            {
                f.ShowDialog();
            }
        }
    }
}

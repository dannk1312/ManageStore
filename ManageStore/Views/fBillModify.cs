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
    public partial class fBillModify : Form
    {
        vw_Bill Bill;
        public List<string> BillItemData;
        public bool isChange = false;
        private vw_Person member;
        public fBillModify(vw_Bill input,vw_Person person = null)
        {
            InitializeComponent();
            member = person;
            Bill = input;
            btnReset_Click(Bill, new EventArgs());
            if(member!=null)
            {
                ckbIsCustomer.Visible = false;
                txtPrice.ReadOnly = true;
                txtPerson.Click -= txtCity_Click;
            }    
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            Bill.Date = dtpDate.Value;
            Bill.Address = txtAddress.Text;
            Bill.TotalPrice = Convert.ToDecimal(txtPrice.Text);
            Bill.isCustomer = ckbIsCustomer.Checked;
            Bill.isDone = ckbDone.Checked;

            if (txtCity.Text != "")
            {
                Bill.CityId = Convert.ToInt32(txtCity.Text.Split(':')[0]);
                Bill.City = txtCity.Text.Split(':')[1];
            }
            if(txtPerson.Text!="")
            {
                Bill.PersonId = Convert.ToInt32(txtPerson.Text.Split(':')[0]);
                Bill.Person = txtPerson.Text.Split(':')[1];
            }
            BillItemData = new List<string>();
            foreach(var i in lbItem.Items)
            {
                BillItemData.Add(i.ToString());
            }

            if(member!=null)
            {
                ObjectParameter mess = new ObjectParameter("Message", "");
                DataProvider.DB.sp_UpdateBill(Bill.BillId,Bill.Date, Bill.PersonId, Bill.TotalPrice, Bill.CityId,
                    Bill.Address, Bill.isCustomer, Bill.isDone, String.Join(";", BillItemData.Select(x => x.Split(':')[0] + "," + x.Split(':')[2])), mess);
                if (mess.Value.ToString().Contains("[S]"))
                {
                    MessageBox.Show(mess.Value.ToString() + (Bill.isDone?", đơn hàng sẽ chuyển tới trong thời gian gần nhất ....":""));
                    if (!Bill.isDone)
                        return;
                }
                else
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
            dtpDate.Value = Bill.Date;
            txtAddress.Text = Bill.Address;
            txtPerson.Text = Bill.PersonId.ToString()+":"+Bill.Person;
            txtPrice.Text = Bill.TotalPrice.ToString();
            ckbIsCustomer.Checked = Bill.isCustomer;
            ckbDone.Checked = Bill.isDone;
            txtCity.Text = Bill.CityId.ToString() + ':' + Bill.City;
            txtPrice.Text = Bill.TotalPrice.ToString();

            lbItem.Items.Clear();
           var listItem = (from run in DataProvider.DB.f_BillItem(Bill.BillId)
                                 select run.ItemId.ToString() + ":[" + run.Code + "]" + run.Name + "("+run.Price.ToString()+"):" + run.Quantity.ToString()).ToList();
            foreach (var i in listItem)
                lbItem.Items.Add(i);
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

        private void txtItem_Click(object sender, EventArgs e)
        {
            using (var f = new fItem(select: true))
            {
                f.ShowDialog();
                if (f.selectItem != null)
                {
                    txtItem.Text = $"{f.selectItem.ItemId}:[{f.selectItem.Code}]{f.selectItem.Name}({f.selectItem.Price})";

                }
            }
        }

        private void txtQuantity_Leave(object sender, EventArgs e)
        {
            for (int i = 0; i < txtQuantity.Text.Length; i++)
            {
                if (txtQuantity.Text[i] < '0' || txtQuantity.Text[i] > '9')
                    txtQuantity.Text = txtQuantity.Text.Substring(0, i) + txtQuantity.Text.Substring(i + 1);
            }
        }

        private void btnAddBillItem_Click(object sender, EventArgs e)
        {
            if (txtItem.Text != "" && txtQuantity.Text != "")
            {
                lbItem.Items.Add(txtItem.Text + ":" + txtQuantity.Text);
                txtItem.Text = txtQuantity.Text = "";
                TotalPrice();
            }
        }

        private void TotalPrice()
        {
            decimal money = 0;
            foreach(var i in lbItem.Items)
            {
                money += Convert.ToDecimal(i.ToString().Split('(')[1].Split(')')[0]);
            }
            txtPrice.Text = money.ToString();
        }
        private void lbItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbItem.SelectedItem != null)
            {
                var mid = lbItem.SelectedItem.ToString().LastIndexOf(':');
                txtItem.Text = lbItem.SelectedItem.ToString().Substring(0, mid);
                txtQuantity.Text = lbItem.SelectedItem.ToString().Substring(mid + 1);
                lbItem.Items.RemoveAt(lbItem.SelectedIndex);
                TotalPrice();
            }
        }

        private void txtPerson_Click(object sender, EventArgs e)
        {
            using (var f = new fPerson(select: true))
            {
                f.ShowDialog();
                if (f.selectPerson != null)
                    txtPerson.Text = $"{f.selectPerson.PersonId}:{f.selectPerson.Name}";
            }
        }
    }
}

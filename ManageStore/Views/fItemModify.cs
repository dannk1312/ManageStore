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
    public partial class fItemModify : Form
    {
        vw_Item Item;
        public List<string> AllCategory;
        public bool isChange = false;
        public fItemModify(vw_Item input)
        {
            InitializeComponent();
            Item = input;

            resetListbox();

            lbCategory.SelectedIndexChanged += LbCategory_SelectedIndexChanged;
            lbSelect.SelectedIndexChanged += LbSelect_SelectedIndexChanged;


            btnReset_Click(Item, new EventArgs());
        }

        private void resetListbox()
        {
            lbCategory.Items.Clear();
            var listCategory = (from run in DataProvider.DB.f_AnotherCategory(Item.ItemId) select run.CategoryId.ToString()+":"+run.Name).ToList();
            foreach (var i in listCategory)
                lbCategory.Items.Add(i);

            lbSelect.Items.Clear();
            var listSelect = (from run in DataProvider.DB.f_ItemCategory(Item.ItemId) select run.CategoryId.ToString() + ":" + run.Name).ToList();
            foreach (var i in listSelect)
                lbSelect.Items.Add(i);
        }
        private void LbSelect_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbSelect.SelectedItem != null)
            {
                lbCategory.Items.Add(lbSelect.SelectedItem);
                lbSelect.Items.RemoveAt(lbSelect.SelectedIndex);
                lbSelect.SelectedItem = null;
            }
        }

        private void LbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lbCategory.SelectedItem != null)
            {
                lbSelect.Items.Add(lbCategory.SelectedItem);
                lbCategory.Items.RemoveAt(lbCategory.SelectedIndex);
                lbCategory.SelectedItem = null;
            }
        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            Item.Name = txtName.Text;
            Item.Code = txtCode.Text;
            Item.Price= Convert.ToDecimal(txtPrice.Text);
            Item.UnitId = Convert.ToInt32(txtUnit.Text.Split(':')[0]);
            Item.Unit = txtUnit.Text.Split(':')[1];
            lbQuantity.Text = Item.Quantity.ToString();

            lbSelect.SelectedIndexChanged -= LbSelect_SelectedIndexChanged;
            AllCategory = new List<string>();
            foreach (var i in lbSelect.Items)
            {
                AllCategory.Add(i.ToString());
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
            txtName.Text = Item.Name;
            txtCode.Text = Item.Code;
            txtPrice.Text = Item.Price.ToString();
            txtUnit.Text = Item.UnitId.ToString()+":"+Item.Unit;
            lbQuantity.Text = Item.Quantity.ToString();

            resetListbox();
        }

        private void txtUnit_Click(object sender, EventArgs e)
        {
            using(var f = new fUnit(select:true))
            {
                f.ShowDialog();
                if (f.selectUnit != null)
                    txtUnit.Text = f.selectUnit.UnitId.ToString() + ":" + f.selectUnit.Name;
            }    
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            new fBill().ShowDialog();
        }
    }
}

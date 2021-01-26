
namespace ManageStore.Views
{
    partial class fBill
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.dgvView = new System.Windows.Forms.DataGridView();
            this.panel3 = new System.Windows.Forms.Panel();
            this.txtFilter = new System.Windows.Forms.TextBox();
            this.cbColumnFilter = new System.Windows.Forms.ComboBox();
            this.ckbFilter = new System.Windows.Forms.CheckBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.lbMessage = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.lbId = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnEdit = new System.Windows.Forms.Button();
            this.txtName = new System.Windows.Forms.TextBox();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvView)).BeginInit();
            this.panel3.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.dgvView);
            this.groupBox1.Controls.Add(this.panel3);
            this.groupBox1.Controls.Add(this.panel2);
            this.groupBox1.Controls.Add(this.lbMessage);
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.Controls.Add(this.txtName);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(0, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(683, 486);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Bill";
            // 
            // dgvView
            // 
            this.dgvView.AllowUserToAddRows = false;
            this.dgvView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvView.Location = new System.Drawing.Point(3, 120);
            this.dgvView.MultiSelect = false;
            this.dgvView.Name = "dgvView";
            this.dgvView.ReadOnly = true;
            this.dgvView.RowHeadersWidth = 51;
            this.dgvView.RowTemplate.Height = 24;
            this.dgvView.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvView.Size = new System.Drawing.Size(677, 346);
            this.dgvView.TabIndex = 18;
            // 
            // panel3
            // 
            this.panel3.Controls.Add(this.txtFilter);
            this.panel3.Controls.Add(this.cbColumnFilter);
            this.panel3.Controls.Add(this.ckbFilter);
            this.panel3.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel3.Location = new System.Drawing.Point(3, 93);
            this.panel3.Name = "panel3";
            this.panel3.Size = new System.Drawing.Size(677, 27);
            this.panel3.TabIndex = 17;
            // 
            // txtFilter
            // 
            this.txtFilter.Dock = System.Windows.Forms.DockStyle.Top;
            this.txtFilter.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtFilter.Location = new System.Drawing.Point(72, 0);
            this.txtFilter.Name = "txtFilter";
            this.txtFilter.Size = new System.Drawing.Size(484, 27);
            this.txtFilter.TabIndex = 17;
            this.txtFilter.Visible = false;
            this.txtFilter.TextChanged += new System.EventHandler(this.txtFilter_TextChanged);
            // 
            // cbColumnFilter
            // 
            this.cbColumnFilter.Dock = System.Windows.Forms.DockStyle.Right;
            this.cbColumnFilter.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.cbColumnFilter.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cbColumnFilter.FormattingEnabled = true;
            this.cbColumnFilter.Location = new System.Drawing.Point(556, 0);
            this.cbColumnFilter.Name = "cbColumnFilter";
            this.cbColumnFilter.Size = new System.Drawing.Size(121, 26);
            this.cbColumnFilter.TabIndex = 16;
            this.cbColumnFilter.Visible = false;
            // 
            // ckbFilter
            // 
            this.ckbFilter.Dock = System.Windows.Forms.DockStyle.Left;
            this.ckbFilter.Location = new System.Drawing.Point(0, 0);
            this.ckbFilter.Name = "ckbFilter";
            this.ckbFilter.Size = new System.Drawing.Size(72, 27);
            this.ckbFilter.TabIndex = 15;
            this.ckbFilter.Text = "Filter";
            this.ckbFilter.UseVisualStyleBackColor = true;
            this.ckbFilter.CheckedChanged += new System.EventHandler(this.ckbFilter_CheckedChanged);
            // 
            // panel2
            // 
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(3, 73);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(677, 20);
            this.panel2.TabIndex = 16;
            // 
            // lbMessage
            // 
            this.lbMessage.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.lbMessage.Location = new System.Drawing.Point(3, 466);
            this.lbMessage.Name = "lbMessage";
            this.lbMessage.Size = new System.Drawing.Size(677, 17);
            this.lbMessage.TabIndex = 15;
            this.lbMessage.Text = "Message:";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.lbId);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.btnAdd);
            this.panel1.Controls.Add(this.btnEdit);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(3, 45);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(677, 28);
            this.panel1.TabIndex = 13;
            // 
            // lbId
            // 
            this.lbId.Dock = System.Windows.Forms.DockStyle.Left;
            this.lbId.Location = new System.Drawing.Point(37, 0);
            this.lbId.Name = "lbId";
            this.lbId.Size = new System.Drawing.Size(91, 28);
            this.lbId.TabIndex = 13;
            this.lbId.Text = "None";
            this.lbId.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // label1
            // 
            this.label1.Dock = System.Windows.Forms.DockStyle.Left;
            this.label1.Location = new System.Drawing.Point(0, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(37, 28);
            this.label1.TabIndex = 12;
            this.label1.Text = "ID:";
            this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnAdd
            // 
            this.btnAdd.Dock = System.Windows.Forms.DockStyle.Right;
            this.btnAdd.Location = new System.Drawing.Point(533, 0);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(72, 28);
            this.btnAdd.TabIndex = 9;
            this.btnAdd.Text = "Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnEdit
            // 
            this.btnEdit.Dock = System.Windows.Forms.DockStyle.Right;
            this.btnEdit.Location = new System.Drawing.Point(605, 0);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(72, 28);
            this.btnEdit.TabIndex = 10;
            this.btnEdit.Text = "Edit";
            this.btnEdit.UseVisualStyleBackColor = true;
            this.btnEdit.Click += new System.EventHandler(this.btnEdit_Click);
            // 
            // txtName
            // 
            this.txtName.Dock = System.Windows.Forms.DockStyle.Top;
            this.txtName.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtName.Location = new System.Drawing.Point(3, 18);
            this.txtName.Name = "txtName";
            this.txtName.ReadOnly = true;
            this.txtName.Size = new System.Drawing.Size(677, 27);
            this.txtName.TabIndex = 8;
            this.txtName.MouseClick += new System.Windows.Forms.MouseEventHandler(this.txtName_MouseClick);
            // 
            // fBill
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(683, 486);
            this.Controls.Add(this.groupBox1);
            this.Name = "fBill";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Bill";
            this.Load += new System.EventHandler(this.fBill_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvView)).EndInit();
            this.panel3.ResumeLayout(false);
            this.panel3.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.DataGridView dgvView;
        private System.Windows.Forms.Panel panel3;
        private System.Windows.Forms.TextBox txtFilter;
        private System.Windows.Forms.ComboBox cbColumnFilter;
        private System.Windows.Forms.CheckBox ckbFilter;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label lbMessage;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label lbId;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.TextBox txtName;
    }
}
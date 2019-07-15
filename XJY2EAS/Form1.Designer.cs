namespace XJY2EAS
{
    partial class Form1
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.radialMenuItem1 = new C1.Win.C1Command.RadialMenuItem();
            this.c1MainMenu1 = new C1.Win.C1Command.C1MainMenu();
            this.c1CommandHolder1 = new C1.Win.C1Command.C1CommandHolder();
            this.c1CommandLink2 = new C1.Win.C1Command.C1CommandLink();
            this.c1Command1 = new C1.Win.C1Command.C1Command();
            ((System.ComponentModel.ISupportInitialize)(this.c1CommandHolder1)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(213, 25);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(258, 64);
            this.button1.TabIndex = 0;
            this.button1.Text = "解压001文件到SqlServer";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(213, 121);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(258, 64);
            this.button2.TabIndex = 1;
            this.button2.Text = "转换中间表";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.Button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(213, 226);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(258, 64);
            this.button3.TabIndex = 2;
            this.button3.Text = "EAS财务数据入库";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.Button3_Click);
            // 
            // radialMenuItem1
            // 
            this.radialMenuItem1.Name = "radialMenuItem1";
            this.radialMenuItem1.Text = "test1";
            this.radialMenuItem1.ToolTip = "test1";
            // 
            // c1MainMenu1
            // 
            this.c1MainMenu1.AccessibleName = "Menu Bar";
            this.c1MainMenu1.CommandHolder = this.c1CommandHolder1;
            this.c1MainMenu1.CommandLinks.AddRange(new C1.Win.C1Command.C1CommandLink[] {
            this.c1CommandLink2});
            this.c1MainMenu1.Dock = System.Windows.Forms.DockStyle.Top;
            this.c1MainMenu1.Location = new System.Drawing.Point(0, 0);
            this.c1MainMenu1.Name = "c1MainMenu1";
            this.c1MainMenu1.Size = new System.Drawing.Size(800, 29);
            // 
            // c1CommandHolder1
            // 
            this.c1CommandHolder1.Commands.Add(this.c1Command1);
            this.c1CommandHolder1.Owner = this;
            // 
            // c1CommandLink2
            // 
            this.c1CommandLink2.Command = this.c1Command1;
            // 
            // c1Command1
            // 
            this.c1Command1.Image = ((System.Drawing.Image)(resources.GetObject("c1Command1.Image")));
            this.c1Command1.Name = "c1Command1";
            this.c1Command1.ShortcutText = "";
            this.c1Command1.Text = "打开（&O）";
            this.c1Command1.Click += new C1.Win.C1Command.ClickEventHandler(this.C1Command1_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 18F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.c1MainMenu1);
            this.Name = "Form1";
            this.Text = "新纪元数据入库";
            ((System.ComponentModel.ISupportInitialize)(this.c1CommandHolder1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        public C1.Win.C1Command.RadialMenuItem radialMenuItem1;
        private C1.Win.C1Command.C1MainMenu c1MainMenu1;
        private C1.Win.C1Command.C1CommandHolder c1CommandHolder1;
        private C1.Win.C1Command.C1Command c1Command1;
        private C1.Win.C1Command.C1CommandLink c1CommandLink2;
    }
}


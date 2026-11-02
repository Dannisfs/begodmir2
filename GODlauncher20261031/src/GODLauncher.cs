using System;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace GODLauncher
{
    public class Program
    {
        [STAThread]
        public static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }

    public class MainForm : Form
    {
        // Win32 API Imports
        [DllImport("user32.dll", SetLastError = true)]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool SetForegroundWindow(IntPtr hWnd);

        [StructLayout(LayoutKind.Sequential)]
        public struct RECT
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        public const int GWL_STYLE = -16;
        public const int WS_THICKFRAME = 0x00040000;    // Allows dragging borders to resize
        public const int WS_MAXIMIZEBOX = 0x00010000;   // Enables Maximize button
        public const int WS_MINIMIZEBOX = 0x00020000;   // Enables Minimize button
        public const int WS_SYSMENU = 0x00080000;       // Enables System Menu and Close button
        public const int WS_CAPTION = 0x00C00000;       // Title bar
        public const int WS_POPUP = unchecked((int)0x80000000);

        public const uint SWP_NOSIZE = 0x0001;
        public const uint SWP_NOMOVE = 0x0002;
        public const uint SWP_NOZORDER = 0x0004;
        public const uint SWP_FRAMECHANGED = 0x0020;
        public const uint SWP_SHOWWINDOW = 0x0040;

        public static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
        public static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);

        // UI Controls
        private Label lblTitle;
        private GroupBox grpStatus;
        private Label lblWebStatus;
        private Label lblDbStatus;
        private Label lblGameStatus;
        private Label lblGateStatus;
        private Label lblRunGateStatus;
        private Button btnRefreshStatus;
        private Button btnStartServer;
        private Button btnStopServer;

        private GroupBox grpAccount;
        private TextBox txtUser;
        private TextBox txtPass;
        private Button btnQuickRegister;
        private Button btnOpenWeb;
        private Label lblRegMsg;

        private GroupBox grpWindow;
        private ComboBox cmbResolution;
        private CheckBox chkResizable;
        private CheckBox chkMaximize;
        private CheckBox chkCenter;
        private CheckBox chkTopmost;
        private CheckBox chkFullscreen;
        private NumericUpDown numCustomWidth;
        private NumericUpDown numCustomHeight;
        private Label lblCustomX;
        private Button btnApplyToGame;

        private Button btnLaunchGame;
        private System.Windows.Forms.Timer statusTimer;

        private string clientDir = @"D:\000GOD\GODclient20261031";
        private string clientExe = "PCClient_Latest.exe";
        private string configFile = @"D:\000GOD\GODlauncher20261031\launcher_config.ini";

        public MainForm()
        {
            InitializeComponent();
            LoadConfig();
            RefreshServerStatus();

            statusTimer = new System.Windows.Forms.Timer();
            statusTimer.Interval = 4000;
            statusTimer.Tick += (s, e) => RefreshServerStatus();
            statusTimer.Start();
        }

        private void InitializeComponent()
        {
            this.Text = "GOD引擎 专属高清登陆器 & 视窗控制器 v2026";
            this.Size = new Size(620, 640);
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.BackColor = Color.FromArgb(24, 24, 28);
            this.ForeColor = Color.WhiteSmoke;
            this.Font = new Font("Microsoft YaHei", 9.5F, FontStyle.Regular);

            // Title
            lblTitle = new Label();
            lblTitle.Text = "★ GOD传奇 专属高清登陆器 & 视窗管理器 ★";
            lblTitle.Font = new Font("Microsoft YaHei", 13F, FontStyle.Bold);
            lblTitle.ForeColor = Color.FromArgb(255, 215, 0); // Gold
            lblTitle.TextAlign = ContentAlignment.MiddleCenter;
            lblTitle.Dock = DockStyle.Top;
            lblTitle.Height = 40;
            this.Controls.Add(lblTitle);

            int yOffset = 45;

            // Group: Server Status
            grpStatus = new GroupBox();
            grpStatus.Text = "【服务端核心状态】";
            grpStatus.ForeColor = Color.FromArgb(255, 200, 100);
            grpStatus.Bounds = new Rectangle(15, yOffset, 575, 80);

            lblWebStatus = new Label() { Text = "Web服务(88): 检测中...", Bounds = new Rectangle(15, 22, 160, 20), ForeColor = Color.LightGray };
            lblDbStatus = new Label() { Text = "数据库(3306): 检测中...", Bounds = new Rectangle(185, 22, 160, 20), ForeColor = Color.LightGray };
            lblGameStatus = new Label() { Text = "游戏服(5000): 检测中...", Bounds = new Rectangle(355, 22, 160, 20), ForeColor = Color.LightGray };
            lblGateStatus = new Label() { Text = "选区网关(8090): 检测中...", Bounds = new Rectangle(15, 48, 160, 20), ForeColor = Color.LightGray };
            lblRunGateStatus = new Label() { Text = "游戏网关(7200): 检测中...", Bounds = new Rectangle(185, 48, 160, 20), ForeColor = Color.LightGray };

            btnRefreshStatus = new Button() { Text = "刷新", Bounds = new Rectangle(355, 46, 60, 25), BackColor = Color.FromArgb(50, 50, 60), ForeColor = Color.White };
            btnRefreshStatus.Click += (s, e) => RefreshServerStatus();

            btnStartServer = new Button() { Text = "一键开服", Bounds = new Rectangle(420, 46, 70, 25), BackColor = Color.FromArgb(70, 40, 40), ForeColor = Color.Gold };
            btnStartServer.Click += (s, e) => StartServerBatch();

            btnStopServer = new Button() { Text = "一键停服", Bounds = new Rectangle(495, 46, 70, 25), BackColor = Color.FromArgb(50, 30, 30), ForeColor = Color.Salmon };
            btnStopServer.Click += (s, e) => StopAllServerAndGates();

            grpStatus.Controls.AddRange(new Control[] { lblWebStatus, lblDbStatus, lblGameStatus, lblGateStatus, lblRunGateStatus, btnRefreshStatus, btnStartServer, btnStopServer });
            this.Controls.Add(grpStatus);

            yOffset += 90;

            // Group: Account & Web
            grpAccount = new GroupBox();
            grpAccount.Text = "【账号注册与网页系统】";
            grpAccount.ForeColor = Color.FromArgb(255, 200, 100);
            grpAccount.Bounds = new Rectangle(15, yOffset, 575, 95);

            Label lblU = new Label() { Text = "账号:", Bounds = new Rectangle(15, 25, 45, 20), ForeColor = Color.White };
            txtUser = new TextBox() { Bounds = new Rectangle(65, 23, 110, 22), BackColor = Color.FromArgb(40, 40, 45), ForeColor = Color.Yellow, Text = "godplayer" };

            Label lblP = new Label() { Text = "密码:", Bounds = new Rectangle(190, 25, 45, 20), ForeColor = Color.White };
            txtPass = new TextBox() { Bounds = new Rectangle(235, 23, 110, 22), BackColor = Color.FromArgb(40, 40, 45), ForeColor = Color.Yellow, Text = "123456" };

            btnQuickRegister = new Button() { Text = "快速注册账号", Bounds = new Rectangle(360, 22, 100, 26), BackColor = Color.FromArgb(30, 80, 30), ForeColor = Color.Lime };
            btnQuickRegister.Click += (s, e) => QuickRegisterAccount();

            btnOpenWeb = new Button() { Text = "打开网页系统", Bounds = new Rectangle(470, 22, 95, 26), BackColor = Color.FromArgb(40, 60, 90), ForeColor = Color.Cyan };
            btnOpenWeb.Click += (s, e) => Process.Start("http://127.0.0.1:88/web/");

            lblRegMsg = new Label() { Text = "提示: 支持网页管理、充值、开区公告与在线改密", Bounds = new Rectangle(15, 60, 545, 25), ForeColor = Color.Gray };

            grpAccount.Controls.AddRange(new Control[] { lblU, txtUser, lblP, txtPass, btnQuickRegister, btnOpenWeb, lblRegMsg });
            this.Controls.Add(grpAccount);

            yOffset += 105;

            // Group: Window & Resolution Settings
            grpWindow = new GroupBox();
            grpWindow.Text = "【PC游戏界面与视窗分辨率设置】";
            grpWindow.ForeColor = Color.FromArgb(255, 200, 100);
            grpWindow.Bounds = new Rectangle(15, yOffset, 575, 210);

            Label lblRes = new Label() { Text = "游戏视窗分辨率:", Bounds = new Rectangle(15, 25, 120, 20), ForeColor = Color.White };
            cmbResolution = new ComboBox() { Bounds = new Rectangle(140, 23, 200, 25), DropDownStyle = ComboBoxStyle.DropDownList, BackColor = Color.FromArgb(40, 40, 45), ForeColor = Color.White };
            cmbResolution.Items.AddRange(new object[] {
                "800 x 600 (复古原版 4:3)",
                "1024 x 768 (经典标清 4:3)",
                "1280 x 720 (720P 高清宽屏 推荐)",
                "1366 x 768 (笔记本常用宽屏)",
                "1600 x 900 (900P 超清宽屏)",
                "1920 x 1080 (1080P 全高清 极佳)",
                "2560 x 1440 (2K 超高清)",
                "自定义分辨率 (输入宽x高)"
            });
            cmbResolution.SelectedIndex = 2; // 1280x720 default
            cmbResolution.SelectedIndexChanged += CmbResolution_SelectedIndexChanged;

            numCustomWidth = new NumericUpDown() { Bounds = new Rectangle(350, 24, 75, 22), Minimum = 640, Maximum = 7680, Value = 1280, BackColor = Color.FromArgb(40, 40, 45), ForeColor = Color.White, Visible = false };
            lblCustomX = new Label() { Text = "x", Bounds = new Rectangle(430, 26, 15, 20), ForeColor = Color.White, Visible = false };
            numCustomHeight = new NumericUpDown() { Bounds = new Rectangle(450, 24, 75, 22), Minimum = 480, Maximum = 4320, Value = 720, BackColor = Color.FromArgb(40, 40, 45), ForeColor = Color.White, Visible = false };

            chkResizable = new CheckBox() { Text = "允许鼠标拖动拉伸边框 (动态自由缩放视窗)", Bounds = new Rectangle(15, 60, 360, 22), Checked = true, ForeColor = Color.LightGreen };
            chkMaximize = new CheckBox() { Text = "激活标题栏【最大化/放大】按钮", Bounds = new Rectangle(15, 88, 300, 22), Checked = true, ForeColor = Color.LightGreen };
            chkCenter = new CheckBox() { Text = "启动后视窗自动屏幕居中", Bounds = new Rectangle(15, 116, 260, 22), Checked = true, ForeColor = Color.White };
            chkFullscreen = new CheckBox() { Text = "全屏模式运行 (F11一键切回窗口)", Bounds = new Rectangle(320, 88, 240, 22), Checked = false, ForeColor = Color.LightSkyBlue };
            chkTopmost = new CheckBox() { Text = "游戏视窗置顶显示 (防止被遮挡)", Bounds = new Rectangle(320, 116, 240, 22), Checked = false, ForeColor = Color.White };

            btnApplyToGame = new Button() { Text = "立即应用视窗设置到已打开的游戏", Bounds = new Rectangle(15, 150, 280, 32), BackColor = Color.FromArgb(50, 70, 100), ForeColor = Color.White };
            btnApplyToGame.Click += (s, e) => ApplySettingsToGameWindow();

            Label lblTip = new Label() { Text = "★ 拖动拉伸支持任意四边边框与四角，随心调整画面大小！", Bounds = new Rectangle(15, 185, 540, 20), ForeColor = Color.Gold };

            grpWindow.Controls.AddRange(new Control[] {
                lblRes, cmbResolution, numCustomWidth, lblCustomX, numCustomHeight,
                chkResizable, chkMaximize, chkCenter, chkFullscreen, chkTopmost,
                btnApplyToGame, lblTip
            });
            this.Controls.Add(grpWindow);

            yOffset += 220;

            // Main Launch Button
            btnLaunchGame = new Button();
            btnLaunchGame.Text = "▶  启 动 游 戏  (应用视窗设置并自动进入)";
            btnLaunchGame.Font = new Font("Microsoft YaHei", 12F, FontStyle.Bold);
            btnLaunchGame.Bounds = new Rectangle(15, yOffset, 575, 50);
            btnLaunchGame.BackColor = Color.FromArgb(160, 40, 40);
            btnLaunchGame.ForeColor = Color.Yellow;
            btnLaunchGame.Cursor = Cursors.Hand;
            btnLaunchGame.Click += (s, e) => LaunchGameAndHook();
            this.Controls.Add(btnLaunchGame);

            this.FormClosing += (s, e) => SaveConfig();
        }

        private void CmbResolution_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isCustom = (cmbResolution.SelectedIndex == cmbResolution.Items.Count - 1);
            numCustomWidth.Visible = isCustom;
            lblCustomX.Visible = isCustom;
            numCustomHeight.Visible = isCustom;
        }

        private void GetTargetResolution(out int w, out int h)
        {
            switch (cmbResolution.SelectedIndex)
            {
                case 0: w = 800; h = 600; break;
                case 1: w = 1024; h = 768; break;
                case 2: w = 1280; h = 720; break;
                case 3: w = 1366; h = 768; break;
                case 4: w = 1600; h = 900; break;
                case 5: w = 1920; h = 1080; break;
                case 6: w = 2560; h = 1440; break;
                default:
                    w = (int)numCustomWidth.Value;
                    h = (int)numCustomHeight.Value;
                    break;
            }
        }

        private void LaunchGameAndHook()
        {
            string targetExePath = Path.Combine(clientDir, clientExe);
            if (!File.Exists(targetExePath))
            {
                MessageBox.Show("未找到客户端主程序: " + targetExePath + "\n请检查客户端文件夹！", "启动失败", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                ProcessStartInfo psi = new ProcessStartInfo();
                psi.FileName = targetExePath;
                psi.WorkingDirectory = clientDir;
                Process.Start(psi);

                lblRegMsg.Text = "游戏启动中，正在连接视窗管理器并应用分辨率...";
                lblRegMsg.ForeColor = Color.Lime;

                // Start background thread to hook window
                Thread hookThread = new Thread(new ThreadStart(HookGameWindowLoop));
                hookThread.IsBackground = true;
                hookThread.Start();
            }
            catch (Exception ex)
            {
                MessageBox.Show("启动游戏异常: " + ex.Message, "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void HookGameWindowLoop()
        {
            IntPtr hWnd = IntPtr.Zero;
            for (int i = 0; i < 40; i++) // Try for 20 seconds
            {
                Thread.Sleep(500);
                hWnd = FindGameWindow();
                if (hWnd != IntPtr.Zero)
                {
                    break;
                }
            }

            if (hWnd != IntPtr.Zero)
            {
                Thread.Sleep(600); // Allow Cocos2d-x initialization to complete
                this.Invoke((MethodInvoker)delegate {
                    ApplySettingsToWindow(hWnd);
                    lblRegMsg.Text = "视窗设置应用成功！鼠标可直接拉伸边框，或点击右上角最大化！";
                    lblRegMsg.ForeColor = Color.Yellow;
                });
            }
            else
            {
                this.Invoke((MethodInvoker)delegate {
                    lblRegMsg.Text = "未捕获到游戏视窗，若已启动可手动点击【立即应用视窗设置】";
                    lblRegMsg.ForeColor = Color.Orange;
                });
            }
        }

        private IntPtr FindGameWindow()
        {
            // 1. Try finding by Window Title
            IntPtr hWnd = FindWindow(null, "GOD引擎-1服");
            if (hWnd != IntPtr.Zero) return hWnd;

            hWnd = FindWindow(null, "GOD引擎");
            if (hWnd != IntPtr.Zero) return hWnd;

            // 2. Try finding by Process Name
            Process[] procs = Process.GetProcessesByName("PCClient_Latest");
            if (procs.Length == 0) procs = Process.GetProcessesByName("PC端_最新");
            if (procs.Length == 0) procs = Process.GetProcessesByName("cocos2dMir2R20250105");

            foreach (var p in procs)
            {
                if (p.MainWindowHandle != IntPtr.Zero)
                {
                    return p.MainWindowHandle;
                }
            }

            return IntPtr.Zero;
        }

        private void ApplySettingsToGameWindow()
        {
            IntPtr hWnd = FindGameWindow();
            if (hWnd == IntPtr.Zero)
            {
                MessageBox.Show("未检测到正在运行的PC客户端视窗！\n请先点击【启动游戏】或确认游戏已打开。", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            ApplySettingsToWindow(hWnd);
            MessageBox.Show("视窗设置已成功应用！\n边框已支持自由拖拽拉伸，最大化按钮已激活！", "应用成功", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void ApplySettingsToWindow(IntPtr hWnd)
        {
            int w, h;
            GetTargetResolution(out w, out h);

            int currentStyle = GetWindowLong(hWnd, GWL_STYLE);

            if (chkFullscreen.Checked)
            {
                // Fullscreen mode
                int screenW = Screen.PrimaryScreen.Bounds.Width;
                int screenH = Screen.PrimaryScreen.Bounds.Height;
                currentStyle &= ~WS_CAPTION;
                currentStyle &= ~WS_THICKFRAME;
                SetWindowLong(hWnd, GWL_STYLE, currentStyle);
                SetWindowPos(hWnd, chkTopmost.Checked ? HWND_TOPMOST : HWND_NOTOPMOST, 0, 0, screenW, screenH, SWP_FRAMECHANGED | SWP_SHOWWINDOW);
            }
            else
            {
                // Windowed mode: Add ThickFrame (resizable) and MaximizeBox
                if (chkResizable.Checked)
                {
                    currentStyle |= WS_THICKFRAME; // Allows border dragging
                }
                if (chkMaximize.Checked)
                {
                    currentStyle |= WS_MAXIMIZEBOX; // Enables maximize button
                }
                currentStyle |= WS_MINIMIZEBOX;
                currentStyle |= WS_SYSMENU;
                currentStyle |= WS_CAPTION;

                SetWindowLong(hWnd, GWL_STYLE, currentStyle);

                // Calculate screen position
                int screenW = Screen.PrimaryScreen.WorkingArea.Width;
                int screenH = Screen.PrimaryScreen.WorkingArea.Height;
                int posX = chkCenter.Checked ? Math.Max(0, (screenW - w) / 2) : 50;
                int posY = chkCenter.Checked ? Math.Max(0, (screenH - h) / 2) : 50;

                SetWindowPos(hWnd, chkTopmost.Checked ? HWND_TOPMOST : HWND_NOTOPMOST, posX, posY, w, h, SWP_FRAMECHANGED | SWP_SHOWWINDOW);
            }

            SetForegroundWindow(hWnd);
        }

        private void RefreshServerStatus()
        {
            Thread t = new Thread(new ThreadStart(delegate {
                bool webOk = IsPortListening("127.0.0.1", 88);
                bool dbOk = IsPortListening("127.0.0.1", 3306);
                bool gameOk = IsPortListening("127.0.0.1", 5000);
                bool gateOk = IsPortListening("127.0.0.1", 8090);
                bool runGateOk = IsPortListening("127.0.0.1", 7200);

                this.Invoke((MethodInvoker)delegate {
                    lblWebStatus.Text = "Web微端(88): " + (webOk ? "● 运行正常" : "○ 未启动");
                    lblWebStatus.ForeColor = webOk ? Color.Lime : Color.Salmon;

                    lblDbStatus.Text = "数据库(3306): " + (dbOk ? "● 运行正常" : "○ 未启动");
                    lblDbStatus.ForeColor = dbOk ? Color.Lime : Color.Salmon;

                    lblGameStatus.Text = "游戏服(5000): " + (gameOk ? "● 运行正常" : "○ 未启动");
                    lblGameStatus.ForeColor = gameOk ? Color.Lime : Color.Salmon;

                    lblGateStatus.Text = "选区网关(8090): " + (gateOk ? "● 运行正常" : "○ 未启动");
                    lblGateStatus.ForeColor = gateOk ? Color.Lime : Color.Salmon;

                    lblRunGateStatus.Text = "游戏网关(7200): " + (runGateOk ? "● 运行正常" : "○ 未启动");
                    lblRunGateStatus.ForeColor = runGateOk ? Color.Lime : Color.Salmon;
                });
            }));
            t.IsBackground = true;
            t.Start();
        }

        private void StopAllServerAndGates()
        {
            try
            {
                string[] procs = new string[] {
                    "RunGate", "Gateway4.3", "LoginGate", "SelGate",
                    "GameServer", "DBServer", "LoginSrv", "LogServer", "GameCenter"
                };
                foreach (var p in procs)
                {
                    foreach (var proc in Process.GetProcessesByName(p))
                    {
                        try { proc.Kill(); } catch { }
                    }
                }
                lblRegMsg.Text = "已安全关停所有服务端与网关进程！";
                lblRegMsg.ForeColor = Color.Yellow;
                RefreshServerStatus();
                MessageBox.Show("所有游戏服务端与网关进程（RunGate/Gateway4.3等）已全部成功安全关闭！", "停服成功", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("关停异常: " + ex.Message, "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private bool IsPortListening(string host, int port)
        {
            try
            {
                using (TcpClient client = new TcpClient())
                {
                    IAsyncResult result = client.BeginConnect(host, port, null, null);
                    bool success = result.AsyncWaitHandle.WaitOne(400);
                    if (!success) return false;
                    client.EndConnect(result);
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        private void QuickRegisterAccount()
        {
            string u = txtUser.Text.Trim();
            string p = txtPass.Text.Trim();
            if (string.IsNullOrEmpty(u) || string.IsNullOrEmpty(p))
            {
                MessageBox.Show("请输入账号和密码！", "提示", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                string url = "http://127.0.0.1:88/web/api.php?action=register";
                string postData = string.Format("username={0}&password={1}&repassword={1}", Uri.EscapeDataString(u), Uri.EscapeDataString(p));
                byte[] bytes = Encoding.UTF8.GetBytes(postData);

                HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
                req.Method = "POST";
                req.ContentType = "application/x-www-form-urlencoded";
                req.ContentLength = bytes.Length;
                req.Timeout = 3000;

                using (Stream os = req.GetRequestStream())
                {
                    os.Write(bytes, 0, bytes.Length);
                }

                using (HttpWebResponse resp = (HttpWebResponse)req.GetResponse())
                using (StreamReader sr = new StreamReader(resp.GetResponseStream(), Encoding.UTF8))
                {
                    string json = sr.ReadToEnd();
                    if (json.Contains("\"code\":200") || json.Contains("\"code\": 200"))
                    {
                        lblRegMsg.Text = "【注册成功】账号: " + u + "，密码: " + p + "，可直接在游戏登入！";
                        lblRegMsg.ForeColor = Color.Lime;
                        MessageBox.Show("账号注册成功！\n账号: " + u + "\n密码: " + p + "\n现在可以在游戏内直接登入了！", "注册成功", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        lblRegMsg.Text = "【注册反馈】" + json;
                        lblRegMsg.ForeColor = Color.Orange;
                        MessageBox.Show("注册提示: " + json, "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("注册请求失败: " + ex.Message + "\n请确认服务端Web(88端口)与数据库(3306)已正常启动！", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void StartServerBatch()
        {
            string batPath = @"D:\000GOD\start_server.bat";
            if (File.Exists(batPath))
            {
                ProcessStartInfo psi = new ProcessStartInfo(batPath);
                psi.WorkingDirectory = @"D:\000GOD";
                Process.Start(psi);
            }
            else
            {
                MessageBox.Show("未找到 start_server.bat", "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void LoadConfig()
        {
            if (File.Exists(configFile))
            {
                try
                {
                    string[] lines = File.ReadAllLines(configFile);
                    foreach (string line in lines)
                    {
                        string[] parts = line.Split('=');
                        if (parts.Length == 2)
                        {
                            string k = parts[0].Trim();
                            string v = parts[1].Trim();
                            if (k == "ResolutionIndex") cmbResolution.SelectedIndex = Math.Min(int.Parse(v), cmbResolution.Items.Count - 1);
                            if (k == "Resizable") chkResizable.Checked = bool.Parse(v);
                            if (k == "Maximize") chkMaximize.Checked = bool.Parse(v);
                            if (k == "Center") chkCenter.Checked = bool.Parse(v);
                            if (k == "Fullscreen") chkFullscreen.Checked = bool.Parse(v);
                            if (k == "Topmost") chkTopmost.Checked = bool.Parse(v);
                            if (k == "CustomW") numCustomWidth.Value = decimal.Parse(v);
                            if (k == "CustomH") numCustomHeight.Value = decimal.Parse(v);
                        }
                    }
                }
                catch { }
            }
        }

        private void SaveConfig()
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("ResolutionIndex=" + cmbResolution.SelectedIndex);
                sb.AppendLine("Resizable=" + chkResizable.Checked);
                sb.AppendLine("Maximize=" + chkMaximize.Checked);
                sb.AppendLine("Center=" + chkCenter.Checked);
                sb.AppendLine("Fullscreen=" + chkFullscreen.Checked);
                sb.AppendLine("Topmost=" + chkTopmost.Checked);
                sb.AppendLine("CustomW=" + numCustomWidth.Value);
                sb.AppendLine("CustomH=" + numCustomHeight.Value);
                File.WriteAllText(configFile, sb.ToString(), Encoding.UTF8);
            }
            catch { }
        }
    }
}

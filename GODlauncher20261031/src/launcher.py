# -*- coding: utf-8 -*-
"""
GOD引擎 专属跨平台桌面登录器 (Python Tkinter 完整源码)
可在 Windows / Linux 平台直接运行，亦可通过 PyInstaller 编译为单文件 EXE:
    pyinstaller -F -w -i icon.ico launcher.py
"""

import sys
import os
import socket
import urllib.request
import urllib.parse
import json
import subprocess
import tkinter as tk
from tkinter import messagebox, ttk

CLIENT_DIR = r"D:\000GOD\GODclient20261031"
CLIENT_EXE = "PCClient_Latest.exe"
API_URL = "http://127.0.0.1:88/api.php"

class GODLauncherApp:
    def __init__(self, root):
        self.root = root
        self.root.title("GOD 传奇引擎专属极速登录器 2026")
        self.root.geometry("780x520")
        self.root.resizable(False, False)
        self.root.configure(bg="#0e0d12")

        self.setup_ui()
        self.check_server_ports()

    def setup_ui(self):
        # 顶部 Banner 区域
        header = tk.Frame(self.root, bg="#18151f", height=80, bd=1, relief="ridge")
        header.pack(fill="x", padx=10, pady=(10, 5))

        title_lbl = tk.Label(header, text="⚔️ GOD 引擎热血极速登录器", font=("Microsoft YaHei", 18, "bold"), fg="#ffd700", bg="#18151f")
        title_lbl.pack(side="left", padx=16, pady=12)

        self.status_lbl = tk.Label(header, text="检测服务器中...", font=("Microsoft YaHei", 10), fg="#aaa", bg="#18151f")
        self.status_lbl.pack(side="right", padx=16)

        # 主体左右双栏
        body = tk.Frame(self.root, bg="#0e0d12")
        body.pack(fill="both", expand=True, padx=10, pady=5)

        # 左栏：区服选择与公告
        left_frame = tk.LabelFrame(body, text=" 游戏区服与公告 ", font=("Microsoft YaHei", 10, "bold"), fg="#ffd700", bg="#14131a", bd=1)
        left_frame.pack(side="left", fill="both", expand=True, padx=(0, 5), pady=5)

        # 区服列表
        server_box = tk.Frame(left_frame, bg="#1f1d28", bd=1, relief="solid")
        server_box.pack(fill="x", padx=12, pady=10)

        server_lbl1 = tk.Label(server_box, text="[1区] 热血首服 (本机极速 127.0.0.1)", font=("Microsoft YaHei", 12, "bold"), fg="#ffd700", bg="#1f1d28")
        server_lbl1.pack(anchor="w", padx=10, pady=4)
        server_lbl2 = tk.Label(server_box, text="端口: 8090 (选区) / 7000 (运行) | 状态: 正常流畅", font=("Microsoft YaHei", 9), fg="#2ecc71", bg="#1f1d28")
        server_lbl2.pack(anchor="w", padx=10, pady=(0, 6))

        # 公告内容
        notice_lbl = tk.Label(left_frame, text="最新更新摘要：\n• 修复 100 秒心跳断线 Bug\n• 修复 RunGate 运行网关卡死问题\n• 修复双击技能书无法学习缺陷\n• 数据库持久化存储 BonusAbil 属性", 
                              font=("Microsoft YaHei", 9), fg="#bbb", bg="#14131a", justify="left")
        notice_lbl.pack(anchor="w", padx=12, pady=8)

        # 右栏：极速通行证注册
        right_frame = tk.LabelFrame(body, text=" 极速账号注册 ", font=("Microsoft YaHei", 10, "bold"), fg="#ffd700", bg="#14131a", bd=1, width=280)
        right_frame.pack(side="right", fill="y", padx=(5, 0), pady=5)
        right_frame.pack_propagate(False)

        tk.Label(right_frame, text="游戏账号:", font=("Microsoft YaHei", 9), fg="#aaa", bg="#14131a").pack(anchor="w", padx=14, pady=(10, 2))
        self.user_entry = tk.Entry(right_frame, font=("Microsoft YaHei", 10), bg="#09080d", fg="#fff", insertbackground="#fff")
        self.user_entry.pack(fill="x", padx=14)
        self.user_entry.insert(0, "hero999")

        tk.Label(right_frame, text="登录密码:", font=("Microsoft YaHei", 9), fg="#aaa", bg="#14131a").pack(anchor="w", padx=14, pady=(8, 2))
        self.pass_entry = tk.Entry(right_frame, font=("Microsoft YaHei", 10), show="*", bg="#09080d", fg="#fff", insertbackground="#fff")
        self.pass_entry.pack(fill="x", padx=14)
        self.pass_entry.insert(0, "123456")

        tk.Label(right_frame, text="安全码 (改密找回):", font=("Microsoft YaHei", 9), fg="#aaa", bg="#14131a").pack(anchor="w", padx=14, pady=(8, 2))
        self.sec_entry = tk.Entry(right_frame, font=("Microsoft YaHei", 10), bg="#09080d", fg="#fff", insertbackground="#fff")
        self.sec_entry.pack(fill="x", padx=14)
        self.sec_entry.insert(0, "888888")

        self.gm_var = tk.IntVar(value=1)
        gm_cb = tk.Checkbutton(right_frame, text="开通 GM 管理员权限", variable=self.gm_var, font=("Microsoft YaHei", 9), fg="#ffd700", bg="#14131a", selectcolor="#09080d")
        gm_cb.pack(anchor="w", padx=14, pady=(10, 10))

        reg_btn = tk.Button(right_frame, text="立即注册账号", font=("Microsoft YaHei", 10, "bold"), bg="#d4af37", fg="#000", activebackground="#ffd700", cursor="hand2", command=self.do_register)
        reg_btn.pack(fill="x", padx=14, pady=5)

        # 底部控制栏
        footer = tk.Frame(self.root, bg="#111017", height=80)
        footer.pack(fill="x", padx=10, pady=(5, 10))

        web_btn = tk.Button(footer, text="🌐 打开网页管理后台", font=("Microsoft YaHei", 9), bg="#222", fg="#ddd", command=self.open_web)
        web_btn.pack(side="left", padx=12, pady=16)

        start_btn = tk.Button(footer, text="🔥 开始游戏", font=("Microsoft YaHei", 14, "bold"), bg="#e67e22", fg="#fff", activebackground="#f39c12", padx=28, pady=4, cursor="hand2", command=self.start_client)
        start_btn.pack(side="right", padx=12, pady=12)

    def check_port(self, host, port, timeout=0.5):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(timeout)
            s.connect((host, port))
            s.close()
            return True
        except:
            return False

    def check_server_ports(self):
        web_ok = self.check_port("127.0.0.1", 88)
        db_ok  = self.check_port("127.0.0.1", 3306)
        gate_ok = self.check_port("127.0.0.1", 8090)

        status_txt = f"Web(88): {'🟢' if web_ok else '🔴'} | MySQL(3306): {'🟢' if db_ok else '🔴'} | 网关(8090): {'🟢' if gate_ok else '🔴'}"
        self.status_lbl.config(text=status_txt)

    def do_register(self):
        user = self.user_entry.get().strip()
        pwd  = self.pass_entry.get().strip()
        sec  = self.sec_entry.get().strip()
        isgm = self.gm_var.get()

        if not user or not pwd:
            messagebox.showwarning("提示", "账号和密码不能为空！")
            return

        data = urllib.parse.urlencode({
            'username': user,
            'password': pwd,
            'repass': pwd,
            'seccode': sec,
            'initgold': 88888,
            'isgm': isgm
        }).encode('utf-8')

        req = urllib.request.Request(f"{API_URL}?action=register", data=data)
        try:
            with urllib.request.urlopen(req, timeout=3) as resp:
                result = json.loads(resp.read().decode('utf-8'))
                if result.get('code') == 200:
                    messagebox.showinfo("注册成功", result.get('msg') + "\n\n您可以点击【开始游戏】登入体验！")
                else:
                    messagebox.showerror("注册失败", result.get('msg'))
        except Exception as e:
            messagebox.showerror("网络错误", f"无法连接到注册服务，请确认 Web 88 端口与 MySQL 是否启动！\n详情: {e}")

    def open_web(self):
        import webbrowser
        webbrowser.open("http://127.0.0.1:88/web/")

    def start_client(self):
        target = os.path.join(CLIENT_DIR, CLIENT_EXE)
        if not os.path.exists(target):
            messagebox.showerror("错误", f"未找到客户端程序：\n{target}")
            return
        try:
            subprocess.Popen([target], cwd=CLIENT_DIR)
        except Exception as e:
            messagebox.showerror("启动异常", f"启动失败：{e}")

if __name__ == "__main__":
    root = tk.Tk()
    app = GODLauncherApp(root)
    root.mainloop()

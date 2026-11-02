procedure onmenu(usource,uplayer:integer);
begin
  menusay(usource,uplayer,'\{20=y}有什么我可以帮你的？\<买/@buy>\\<卖/@sell>\\<测试/@funtake>',false,2292,300,410);
end;

procedure task1(usource,uplayer:integer);
{  TMsgColor = (c_Red, c_Green, c_Blue, c_White);  //[0..3]
  TMsgType = (t_Notice, t_Hint, t_System, t_Say, t_Mon, t_GM, t_Cust, t_Castle, t_Cudt);}
  const
   MsgColor=1;
   msgtype=1;
begin
 sysmsg(uplayer,MsgColor,msgtype,'屠夫脚本');
 //menusay(usource,uplayer,'<修理/@repair>\\',false,2292,300,410);
end;

procedure funtake(usource,uplayer:integer);
begin
take(usource,uplayer,'金币',10);
end;

procedure xs(usource,uplayer:integer);
{  TMsgColor = (c_Red, c_Green, c_Blue, c_White);  //[0..3]
  TMsgType = (t_Notice, t_Hint, t_System, t_Say, t_Mon, t_GM, t_Cust, t_Castle, t_Cudt);}
  const
   MsgColor=1;
   msgtype=1;
begin
 sysmsg(uplayer,MsgColor,msgtype,getmapname(uplayer,1));
 //menusay(usource,udest,'<ÐÞÀí/@repair>\\',false,2292,300,410);
end;

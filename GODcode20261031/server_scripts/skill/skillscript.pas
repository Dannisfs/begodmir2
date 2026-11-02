
/////////////////////////// 这个函数不要动
function MakeLong(A, B: Word): Longint;
begin
  Result := A or B shl 16;
end;
////////////////////////////////

procedure Attack(uSource,x1,y1,target,x2,y2,whitmode:integer); //物理攻击函数调用
begin
{  case whitmode of //这里是根据不同的whitmode来选择不同的特效  usource是自己,x1,y1是自己坐标，target是攻击对象，x2,y2是攻击对象坐标

  7:    //演示烈火
  begin

      //这里236是 myeffect.pak里特效的开始位置，12是指定的播放帧数   这里改完要从引擎那里重新加载下自定义特效脚本，不用重启M2
  Attackeffect(target,makelong(236,12),x2,y2);   //这个例子就是在攻击目标上显示特效
 //Attackeffect(usource,makelong(236,12),x1,y1);  // 这个是在自己身上显示特效
  PushArround(uSource,0);
  Makepoisonx(target,6, 6000, 100) ;  //POISON_DECHEALTH = 0; //中毒类型 - 绿毒   60是时间  最后一个100是啥我也不知道

  end;
  end; }
end;

procedure Magic(uSource,usermagic,x1,y1,target,x2,y2, nMagID:integer); //魔法攻击函数调用
begin
  {case nMagID of //这里是根据不同的magicid来选择不同的特效
  0:;
  1:;
  2:;
  end;
     //这里236是 myeffect.pak里特效的开始位置，12是指定的播放帧数   这里改完要从引擎那里重新加载下自定义特效脚本，不用重启M2
     //这些代码如果不写在case结构里，就是所有的魔法攻击都支持这个调用 ，这里是测试用的
 Replacemagiceffect(uSource,TargeT,x2,y2,7,9);
 Attackeffect(usource,makelong(236,12),x1,y1);
 Attackeffect(target,makelong(236,12),x2,y2);
 PushArround(uSource,usermagic); }
end;




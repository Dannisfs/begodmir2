# SKILL-04: 数据库结构平滑迁移与 BonusAbil 永久属性字段扩展

## 技能定位
讲解 God 引擎数据库表设计特点、角色数据持久化机制，以及如何在不破坏现有玩家数据的前提下增加新字段（以 `BonusAbil` 永久属性字段为例）。

---

## 一、为什么必须增加 BonusAbil 字段？

在 2024-11 更新的日志中：
> 13、修复出售物品无法批量问题 修复PlaySoundext和PlaySound命令 修复usebonuspoint永久属性问题(20241128)

- **核心机制**：
  传奇引擎中，玩家升级属性点分配（攻击、魔法、道术、防御、魔御、生命值等）通过脚本命令 `usebonuspoint` 实施。
- **历史缺陷**：
  若数据库 `character` 表中未设计独立存储加点结构的字段，玩家在离线重新上线后，属性会被重置为基础属性，导致加点丢失。
- **解决方案**：
  在 `character` 表中扩充 `BonusAbil` 字段（数据类型为 `text`，支持序列化键值对存储），由 DBServer 在角色存盘时自动将人物属性增量打包存入该字段。

---

## 二、生产环境安全热更新 SQL

若当前已有玩家运行数据，**千万不要执行 `DROP TABLE character`**！请执行以下增量修改语句：

```sql
-- 检查并追加 BonusAbil 字段
ALTER TABLE `character` 
ADD COLUMN `BonusAbil` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '永久属性' AFTER `serverid`;
```

若为全新搭建测试服：
直接执行 `D:\000GOD\GODserver20261031\Mirserver\DBServer\character_patch_20241206.sql`，即可一键生成具备全部 78 个完备字段的最新角色表结构。

---

## 三、验证字段是否生效
1. 进游戏用 GM 命令或者 NPC 脚本调用 `usebonuspoint 1 10` 给玩家增加 10 点攻击。
2. 小退并重新大退游戏。
3. 打开 Navicat 查询 `SELECT name, BonusAbil FROM character WHERE name = '你的角色名';`
4. 若 `BonusAbil` 列有对应加点序列化字符串，且再次登录游戏加成仍存在，即证明升级成功！

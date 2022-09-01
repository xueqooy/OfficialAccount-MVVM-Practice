# OfficialAccount-MVVM-Practice
ND's iOS primary certification test.

iOS端试题
题目1：实现原型中的功能。具体详见【实现要求】
工程已搭好框架和实现以下界面
	•	公众号列表
	•	推荐公众号列表
	
需开发：
需实现公众号列表和推荐公众号列表的数据源的获取和处理。
需实现推荐公众号的关注公众号
需解决内存暴涨问题
请求地址:
公众号列表：http://official-account.edu.web.sdp.101.com/list
返回结果：{“items”:[
{“OAID”:”123456”,”title”:”公众号”,”avatarUrl”:”https://xxxx”},
{ OAID”:”123456”,”title”:”公众号”,”avatarUrl”:”https://xxxx”},
]
}
推荐列表：http://official-account.edu.web.sdp.101.com/recommend
返回结果：同上
关注：http://official-account.edu.web.sdp.101.com/follow/%@"
返回结果：{“OAID”:”123456”}
原型地址：./公众号列表.mp4


实现要求：
	•	整体要求
	•	运用脚手架进行开发，推荐使用Cocoapods
	•	推荐使用AFNetWorking作为HTTP请求异步库，使用Mantle作为json转模型
	•	推荐使用FMDB作为数据库的操作
	•	保持良好的项目目录结构，正确拆分页面开发
	•	保持良好的代码风格、代码可读性
	•	 “公众号”页面
	•	列表
	•	数据需要第一次从服务端拉取，后续直接数据库读取
	•	数据可服务端一次性拉取
	•	 “关注公众号”页面
	•	点击cell项弹出确认关注弹窗，实现关注公众号
	•	返回公众号主页面，刚新关注的公众号需要刷新显示
评分标准:
	•	成功关注公众号后，返回公众号列表需显示刚关注成功的公众号： (10分)
	•	数据库 表的创建、操作 (30分)
	•	服务端数据的获取、操作以及json转换(30分)
	•	OC的合理使用：变量声明，block定义、代码规范等。（10分）
	•	合理的目录、界面的拆分。（10分）
	•	保证页面打开后能正常运行。（10分）

任务提交清单:
	•	项目源码

技能要求：
	•	OC
	•	UIKit以及常用第三方库


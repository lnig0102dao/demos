import 'package:flutter/material.dart';

class BasicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("basicWidget"),
        ),
        body: new ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TextTest(),
            new BtnTest(),
            new ImgTest(),
            new CheckBoxTest(),
            new FormTest(),
          ],
        ));
  }
}

/**
 * 文字
 */
class TextTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.red,
      ),
      child: Text.rich(TextSpan(children: [
        TextSpan(text: "DefaultTextStyle: "),
        TextSpan(
          text: "https://flutterchina.club" * 3,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.0,
            height: 1.2, //具体的行高等于fontSize*height
            fontFamily: "Courier",
            background: new Paint()..color = Colors.yellow,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
          ),
        ),
      ])),
    );
  }
}

/**
 * 按钮
 */
class BtnTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        RaisedButton(
          child: Text("RaisedButton"),
          onPressed: () => {}, //没有onPress就是禁用状态
        ),
        FlatButton(
          child: Text("flutterButton"),
          onPressed: () => {},
        ),
        OutlineButton(
          child: Text("OutlineButton"),
          onPressed: () => {},
        ),
        IconButton(
          icon: Icon(Icons.thumb_up),
          onPressed: () => {},
        ),
        FlatButton(
          color: Colors.blue,
          highlightColor: Colors.blue[700],
          colorBrightness: Brightness.dark,
          splashColor: Colors.grey,
          child: Text("自定义"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => {},
        )
      ],
    );
  }
}

/**
 * 图片，图标
 */
class ImgTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Image.asset('assets/images/avatar.png', width: 100),
        Image.network(
          'https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/image-20180829163427556.png',
          width: 100,
          height: 200.0,
          repeat: ImageRepeat.repeatY,
          color: Colors.blue,
          colorBlendMode: BlendMode.difference,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.accessibility,
              color: Colors.green,
            ),
            Icon(
              Icons.error,
              color: Colors.red,
            ),
            Icon(
              Icons.fingerprint,
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}

/**
 * 单选框，复选框
 */
class CheckBoxTest extends StatefulWidget {
  @override
  _CheckBoxTest createState() => new _CheckBoxTest();
}

class _CheckBoxTest extends State<CheckBoxTest> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          activeColor: Colors.blue,
          value: _switchSelected,
          onChanged: (value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red,
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        )
      ],
    );
  }
}

/**
 * 表单
 */
class FormTest extends StatefulWidget {
  @override
  _FormTest createState() => new _FormTest();
}

class _FormTest extends State<FormTest> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Form(
          key: _formKey,//设置globalKey，用于后面获取FormState
          autovalidate: true,//开启自动校验
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true, //是否自动获取焦点
                style: TextStyle(color: Colors.green, fontSize: 13.0), //编辑的文本样式
                keyboardType: TextInputType.emailAddress, //输入框默认的键盘输入类型
                textInputAction: TextInputAction.next, //键盘动作按钮图标(即回车键位图标)
                maxLines: 1, //输入框的最大行数，默认为1；如果为null，则无行数限制。
                maxLength: 20, //文本的最大长度，设置后右下角会显示输入的文本计数
                maxLengthEnforced: true, //true时会阻止输入，为false时不会阻止输入但输入框会变红
                onChanged: (v) =>
                    {print('value:$v')}, //内容改变时的回调函数,也可以通过controller来监听
                onSubmitted: (v) => {print('submit:$v')}, //输入完成时触发
                controller: _emailController, //除了能监听文本变化外，它还可以设置默认值、选择文本
                focusNode: _emailFocus, //关联focusNode1
                enabled: true,
                cursorWidth: 1, //光标宽度
                cursorRadius: Radius.circular(10.0), //光标圆角
                cursorColor: Colors.red, //光标颜色
                decoration: InputDecoration(
                    //外观
                    labelText: "Email",
                    hintText: "电子邮件地址",
                    hintStyle: TextStyle(color: Colors.red, fontSize: 13.0),
                    prefixIcon: Icon(Icons.email)),
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true, //隐藏显示，如密码
                  focusNode: _passwordFocus,
                  controller: _passwordController,
                  // onChanged: (v) => {},//托管表单之后就没有自己的onchanged事件了
                  // onSubmitted: (v) => {},//托管表单之后就没有自己的onSubmitted事件了
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              FlatButton(
                child: Text("controller print && 隐藏键盘"),
                onPressed: () {
                  _emailFocus.unfocus();
                  _passwordFocus.unfocus();
                  print('emailController:${_emailController.text}');
                },
              ),
              FlatButton(
                child: Text("next focus"),
                onPressed: () =>
                    {FocusScope.of(context).requestFocus(_passwordFocus)},
                //FocusScope.of(context) 来获取widget树中默认的FocusScopeNode
              ),
              FlatButton(
                  child: Text("submit"),
                  onPressed: () {
                    //在这里不能通过此方式获取FormState，context不对
                    //print(Form.of(context));

                    // 通过_formKey.currentState 获取FormState后��
                    // 调用validate()方法校验用户名密码是否合法，校验
                    // 通过后再提交数据。
                    if ((_formKey.currentState as FormState).validate()) {
                      //验证通过提交数据
                    }
                  }),
            ],
          ),
        )
      ],
    );
  }
}

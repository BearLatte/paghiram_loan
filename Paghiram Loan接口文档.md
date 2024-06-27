#### BaseUrl: https://api.paghiram.top/Api

#### code 错误码汇总

| 错误代码 | 错误描述       | 处理方式                 |
| -------- | -------------- | ------------------------ |
| 105      | Unknown device | 登录时需要申请短信验证码 |
| 103      | Token error | token 过期，重新登录|

#### 1. 首页

- 接口地址：`/Home/index`

- 请求方式：`Get`

- 请求参数：无

- 返回值

  ```json
    {
      "code": 200,
      "status": 0,
      "error": "Please login",
      "update_state": 1,
      "app_version": 1,
      "i_update_state": 1,
      "i_app_version": 1,
      "mail_list": 1,
      "service_one": "9090773263",
      "service_two": "9090773130",
      "update_addr": "",
      "sms_check": 2,
      "data": [
        {
          "id": "2",
          "product_name": "Paghiram",
          "app_names": "Paghiram - Shopping Installment Loan",
          "min_money": "2000",
          "max_money": "50000",
          "interest": "0.0000",
          "flag": "1",
          "loan_time": "2 Hours",
          "loan_term": "91 - 120 Days",
          "logo_img": "/Public/img/CashPeso.png",
          "is_loan": 1,
          "overdue_days": 0,
          "back_time": 0,
          "money": 0,
          "status": 0 // 0: 未登录，1：未认证，2：审核中，3：可借款，4：审核失败（资料回退），5：还款，6：再次借款，7：线下提款，8：审核被拒，9：打款中，10：打款失败，重新申请， 11：前置流程，已忽略，12：认证资料完成未提交
        }
      ]
    }
  ```

#### 2. 发送验证码

- 接口地址：
1. `/Reg/send_verify_code`（注册）
2. `/Login/send_verify_code`(重置密码)
3. `/Login/sms_login_code`(登录)
- 请求方式：`Post`

- 请求参数:

  | 参数名称 | 说明            | 参数类型 | 是否必传 |
  | -------- | --------------- | -------- | -------- |
  | phone    | 手机号          | String   | true     |
  | packname | 项目名称        | String   | true     |
  | type     | 取值范围 注册=2 | Integer  | true     |

- 返回参数：

  ````json
    {
      "code":"200",
      "error":"Success",
      "data":[]
    }
  ````

#### 3. 检查手机号是否可以注册

- 接口地址：`/Reg/tel_status`

- 请求方式：`Get`

- 请求参数：

  | 参数名称 | 说明       | 参数类型 | 是否必传 |
  | -------- | ---------- | -------- | -------- |
  | phone    | 手机号     | String   | true     |
  | code     | 手机验证码 | String   | true     |

- 返回值

  ```json
    {
      "code":"201", // 201 可注册，202 可登录
      "error":"Please register",
      "data":[]
    }
  ```

#### 4. 注册

- 接口地址: `/Reg/register`

- 请求方式:`Post`

- 请求参数:

  | 参数名称 | 说明       | 参数类型 | 是否必传 |
  | -------- | ---------- | -------- | -------- |
  | phone    | 手机号     | String   | true     |
  | password    | 密码     | String   | true     |
  | code    | 验证码     | String   | true     |
  | type    | 来源类型，1：安卓，2：iOS     | String   | true     |
  | version    | 当前版本号   | String   | true     |
  | tel_device_id    | UUID MD5加密后的串   | String   | true     |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Register success",
      "data":{
        "mobile":"9393939393"
      }
    }
  ```

#### 5. 登录前检测设备风险

- 接口地址: `/Login/login_risk_control`

- 请求方式: `Post`

- 请求参数:

  | 参数名称 | 说明       | 参数类型 | 是否必传 |
  | -------- | ---------- | -------- | -------- |
  | phone    | 手机号（如果0开头，需要传参时去掉0）     | String   | true     |
  | password    | 密码     | String   | true     |
  | dev_id    | UUID MD5加密后的串     | String   | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Successful",
      "data":{
        "code_type":1 // 1: 不弹出验证码输入框，0：弹出验证码输入框
      }
    }
  ```

#### 6. 登录

- 接口地址: `/Login/index`

- 请求方式: `Post`

- 请求参数:

  | 参数名称      | 说明                      | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | phone         | 手机号                    | String   | true     |
  | password      | 密码                      | String   | true     |
  | type          | 来源类型：1：安卓，2：iOS | String   | true     |
  | version       | 当前版本号                | String   | true     |
  | tel_device_id | UUID MD5加密后的串        | String   | true     |

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Login success",
    "data":{
      "token":"bUl6ZkxXbEtQTlNqMndSYzJob1JqZzBTcUgzTElteFBqK1l0b1h0alJUdmsrazdxVlRmbFZCSk9tdnp4WE4xMS9iMExOY3kza3R4eDNjMWlGVFRTQnlUN3BlcklGR1plSVpjVlFBNUZHenZDaTQ2MnNLT0xlMGVEcm5pcG1ZVHR1b0ppWHVGWHB1R2g3ZjZrM2N1WkZiRFl3VjZiS1hyQ21MSkhxSU5CTHk0PQ==",
      "phone":"9898989898"
    }
  }
  ```

#### 6. 修改密码前检测手机号和验证码是否可用

- 接口地址: `Login/check_phone_verification`

- 请求方式: `Get`

- 请求参数:

  | 参数名称      | 说明                      | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | phone         | 手机号                    | String   | true     |
  | code      | 验证码                      | String   | true     |

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data":[]
  }
  ```


#### 7. 重置密码

- 接口地址: `/Login/save_new_password`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | phone  | 手机号| String   | true     |
  | code| 验证码| String|true|
  |pass_one|密码1|String|true|
  |pass_two|密码2|String|true|

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data":[]
  }
  ```

#### 8. 身份认证流程中的可选参数获取
- 接口地址: `/UserBaseData/getBaseItem`

- 请求方式: `Post`

- 请求参数: 无

- 返回值:

  ```json
    {
      "eschool": Array[7],      // 教育背景
      "merry_state": Array[4],  // 婚姻状况
      "kid_number": Array[5],   // 子女情况
      "liv_time": Array[5],     // 居住时间
      "my_work": Array[22],     // 工作信息
      "user_work": Array[7],    // 工作年限
      "my_salary": Array[9],    // 收入
      "user_religion": Array[5],// 宗教
      "branch": Array[37],      // 行业信息
      "lvl_time": Array[5],     // 住所信息（租赁还是自有）
      "fr": Array[4],           // 联系人关系
      "ctype": Array[15],       // 身份卡类型
      "loan_pur": Array[9],     // 借款目的
      "ubll": Array[5],         // 没用到
      "ito": Array[25],         // 同身份卡类型，暂不知道怎么用
      "relist": Object{...}     // 联系人关系
    }
  ```

#### 9. 保存用户基本信息
- 接口地址: `/UserBaseData/add`

- 请求方式: `Post`

- 请求参数: 
  ```json
  {
    "branch": "Police Officer",         // industry
    "client_carrer": "",                // 行业，不传了
    "client_religion": "Buddhism",      // 宗教
    "client_salary": "₱ 13,000-15,000", // 薪水
    "company_name": "Dafdasfdas",
    "email": "Dadafasd@yahoo.com",      
    "eschool": "Professional Diploma",  // 教育背景
    "fbk_name": "Fedfasfew",            // facebookMessengerLinkAccount 名称
    "gx_five": "Relative",              
    "gx_four": "Neighbor",
    "gx_name": "John Appleseed",       // 联系人1姓名
    "gx_name_five": "Rose L",
    "gx_name_four": "Kevin J",
    "gx_name_three": "Jimy D",
    "gx_name_two": "Jobs Steve",
    "gx_one": "Mother",               // 联系人1关系
    "gx_phone": "08885555512",        // 联系人1手机号
    "gx_phone_five": "09643521783",
    "gx_phone_four": "08764532150",
    "gx_phone_three": "08976543343",
    "gx_phone_two": "09734626543",
    "gx_three": "Friend",
    "gx_two": "Spouse",
    "hbl": "Parental Ownership",        // 住宅所有权
    "kid_number": "2",                  // 子女数量
    "latitude": "37.785834",
    "longitude": "-122.406417",
    "lv_addr": "Dsafdsafasdfdas",       // 住所详细地址
    "lv_city": "BANGUED (Capital)",     // 居住城市
    "lv_pro": "ABRA",                   // 居住省份
    "lv_stre": "Agtangao",              // 居住区县
    "lv_time": "",                      // 居住时长
    "merry_state": "Divorced",         // 婚姻状态
    "pay_date_one": "31",               // 发薪日1
    "pay_date_two": "4",                // 发薪日2
    "second_mobile": "8886655568",      // 备用手机号
    "usage_type": "Personal daily consumption",
    "whatsapp": "655588558",            // viber phone number
    "wk_addr": "Fasfdsafdsafasd",       // 公司地址
    "wk_pro": "ABRA BANGUED (Capital) Cosili West (Buaya)",   // 公司所在省份
    "work_time_long": "More than 10 years"  // 工作年限
  }
  ```

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":[]
    }
  ```

#### 10. 获取认证状态
- 接口地址: `/ProductApply/index`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code": 200,
    "data": {
        "face_state" : 0,
        "identity_state":1
    },
    "error": "Request success"
  }
  ```

#### 10. 获取活体认证的token
- 接口地址: `/Licensepgm/get_licensepgm`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code":"200",
    "error":"OK",
    "data":{
      "license":"" // 活体认证的token
    }
  }
  ```

#### 11. 获取身份卡类型

- 接口地址: `/OptionPhoto/cert_type`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data":[
      {
        "id":"1",
        "title":"UMID"
      }
    ]
  }
  ```

#### 12. 获取人脸照片

- 接口地址: `/UserCard/pgm_ocr_live`

- 请求方式: `Post`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code": 200,
    "data": {
        "live_id" : "<null>",
        "pgm_photo":""
    },
    "error":"Success"
  }
  ```

#### 13. 获取 aliyun key 相关接口

- 接口地址: `/GetAccessKey/index`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code":200,
    "data": {
      "AccessKeyId":"STS.NTrCt34cXBp59Xzt1KXLSPFBa",
      "AccessKeySecret" : "8TwPSZED3UZFPAF7z5WA1DEvSzE6FBLgt2mFRxrarKRg",
      "Expiration" : "2024-04-25T09:46:39Z",
      "SecurityToken" : "xxxxxxxx",
      "StatusCode": 200
    },
    "error":"Success"
  }
  ```

#### 14. 身份证调用 OCR

- 接口地址：`/OptionPhoto/cert_img_ad`

- 请求方式: `Post`

- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | img|阿里云上传的图片名称| String|true|
  |card_type|身份卡类型，共7种|String|true|
  |liveness_id|活体认证id|String|false|
  |type|OCR类型，身份证识别 传 2|String|true|

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data":{
      "first_name":"JOSEPH",
      "middle_name":"GESTOSO",
      "last_name":"MARQUEZ JR",
      "id_card":"0009-2229064-2",
      "gender":"M",
      "birthday":""
    }
  }
  ```

#### 15. 人脸识别图片上传完成后通知服务器
- 接口地址：`/UserCard/upload_photo`

- 请求方式: `Post`

- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | photo_file|阿里云上传的图片名称| String|true|
  |livenessId|人脸识别后SDK返回的id|String|true|
  |type|活体认证，传 1|String|true|

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data":[]
  }
  ```

#### 16. 提交个人证件信息

- 接口地址：`/UserCard/add`

- 请求方式: `Post`

- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | first_name| first name | String|true|
  |middle_name| middle name |String|false|
  |last_name| last name |String|true|
  |card_id_number|证件号码 |String|true|
  |type|证件类型 |String|true|
  |gender| 性别 |String|true|
  |birthday|生日|String|true|
  |mobile_mode|手机类型，iOS 传 iPhone |String|true|
  |back_status|不知道做什么用，传 1 |String|true|
  |aoid|证件识别 传 2 |String|true|
  |go_id|GOOGLE_AD_ID传 2 |String|true|

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data": []
  }
  ```



#### 16. 提交认证数据

- 接口地址：`/ProductApply/add`

- 请求方式: `Post`

- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | product_id | 产品id | String | true |

- 返回值:

  ```json
  {
    "code":"200",
    "error":"Success",
    "data": []
  }
  ```

#### 17. 提交反馈

- 接口地址：`/Quiz/save`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | ------------- | ------------------------- | -------- | -------- |
  | product_id | 产品id | String | true |

- 返回值:
  ```json
  ```


#### 18. 注销账号

- 接口地址: `/Login/cancel_user`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:
  
  ```json
  {
    "code": 200,
    "data": {},
    "error": "Success"
  }
  ```

#### 19. 获取在线客服url地址

- 接口地址: `/Login/get_info`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:
  
  ```json
  {
    "code": 200,
    "data": {
      "fbu":""
    },
    "error": "Success"
  }
  ```

#### 20. OCR数据回显接口

- 接口地址: `/UserCard/index`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
  {
    "code":"200",
    "error":"",
    "data":{
      "birthday":"01012002",
      "gender":"Male",
      "id_number":"000922290642",
      "type":"UMID",
      "other":null,
      "first_name":"JOSEPH",
      "middle_name":"",
      "last_name":"MARJR"
    }
  }
  ```

#### 21. 点击借款，借款详细展示

- 接口地址: `/instalmentData/getRatePgm`
- 请求方式: `Get`
- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | product_id | 产品id | String | true |

- 返回值:

  ````json
  {
    "code": "200",
    "error": "Success",
    "data": {
      "min_days": "6",
      "max_days": "6",
      "time": 1717648313,
      "max_price": "2000",
      "user_data": [
        {
          "term_id": "2",
          "days": "6",
          "show_days": 7,
          "info": {
            "pro_id": "6",
            "pro_type": "0",
            "instalment_num": 1,
            "min": "2000",
            "max": "23000",
            "money": "2000",
            "data": [
              {
                "rid": "32",
                "amount": 23000,
                "service_fee": 8280,
                "credit_price": 4025,
                "manage_price": 4255,
                "interest": 690,
                "tech_price": 0,
                "real_price": 14720,
                "repay_price": 23690
              }
            ]
          }
        }
      ]
    }
  }
  ````

#### 22. 借款详情
- 接口地址: `/instalmentData/getInsDataPgm`

- 请求方式: `Post`

- 请求参数: 

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | days | 产品期限 | String | true |
  | price | 借款金额 | String | true |
  | pro_id | 不懂 | String | true |
  | product_id | 产品id | String | true |
  | rate_id | 费率id | String | true |
  | tid | 不懂 | String | true |

- 返回值: 

```json
{
  "code":"200",
  "error":"Success",
  "data":{
  "loan_amount":2000,
  "loan_term":7,
  "issued_amount":1280,
  "service_fee":720,
  "credit_price":350,
  "manage_price":370,
  "tech_price":0,
  "repay_data":[
      {
        "back_time":"06-18-2024",
        "principal":2000,
        "repay_price":2060,
        "interest":60
      }
    ]
  }
}
```

#### 23， 获取绑定银行卡列表

- 接口地址: `/Bank/get_user_banks`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":[
        {
          "is_default":"1",
          "name":"AUB",
          "bank_number":"6468468468468468",
          "id":"20204"
        }
      ]
    }
  ```

#### 24. 获取绑定电子钱包列表
- 接口地址: `/ElectronicWallet/get_user_wallet`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":[
        {
          "is_default": "",
          "wa_id":"6",
          "id":"152427",
          "account_number":"09800000000",
          "title":"GCash"
        }
      ]
    }
  ```

#### 25. 获取电子钱包种类列表

- 接口地址: `/ElectronicWallet/get_wallet`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":[
        {
          "id":"6",
          "title":"GCash"
        },
        {
          "id":"8",
          "title":"Paymaya"
        },
        {
          "id":"15",
          "title":"GrabPay"
        }
      ]
    }
  ```

#### 26. 获取绑定电子钱包或者银行卡的姓名

- 接口地址: `/Bank/bind_data`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:
  ```json
  {
    "code": "200",
    "error":"",
    "data": {
      "name_one": "JOSEPH",
      "name_three":"MARQUEZ JR",
      "name_two":"GESTOSO"
    }
  }
  ```

#### 27. 添加电子钱包

- 接口地址: `/ElectronicWallet/add`

- 请求方式: `Post`

- 请求参数: 
  
  ```json
  {
    "data": {
      "account_number":"",    // 账号
      "channel_id":"",        // 电子钱包id
    }
  }
  ```

- 返回值: 无


#### 28. 获取可选银行列表

- 接口地址: `/Bank/get_bank_list`

- 请求方式: `Get`

- 请求参数: 无

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":[
        {
          "bankid":"4",
          "bankname":"AUB",
          "longname":"Asia United Bank",
          "status":"1"
        }
      ]
    }
  ```



#### 29. 添加银行卡

- 接口地址: `/Bank/add`

- 请求方式: `Post`

- 请求参数: 

  ```json
  {
    "data": {
      "username":"",    
      "phone":"",       
      "bank_number":"",
      "bid":""
    }
  }
  ```

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":[
        {
          "bankid":"4",
          "bankname":"AUB",
          "longname":"Asia United Bank",
          "status":"1"
        }
      ]
    }
  ```

#### 30. 判断是否需要设备验证

- 接口地址: `/Paytwo/control_version`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | dev_id | 设备标识 | String | true |
  | pay_type | 借款类型（1：电子钱包；2：银行卡） | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Successful request",
      "data": {
        "code_type":1
      }
    }
  ```

#### 31. 取款设备认证发送手机号

- 接口地址: `/Paytwo/pay_sms_code`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | phone | 手机号 | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":[]
    }
  ```

#### 32. 电子钱包取款

- 接口地址: `/payIns/wallPayPgm`

- 请求方式:  `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | price | 借款金额 | String | true |
  | product_id | 产品id | String | true |
  | tid | 借款期限id | String | true |
  | rateid | 费率id | String | true |
  | days | 借款时长 | String | true |
  | user_passwords | 借款密码 | String | true |
  | acu_number | 电子钱包账户 | String | true |
  | wc_id | 电子钱包类型id | String | true |
  | pro_id | 不懂 | String | true |
  | dev_id | 设备标识码 | String | true |
  | sms_code | 短信验证码 | String | false |

- 返回值:

  ```json
    {
      "code":"105",
      "error":"Incorrect user info ",
      "data": []
    }
  ```

#### 33. 银行卡取款

- 接口地址: `/payIns/payBankPgm`

- 请求方式:  `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | price | 借款金额 | String | true |
  | product_id | 产品id | String | true |
  | tid | 借款期限id | String | true |
  | rateid | 费率id | String | true |
  | days | 借款时长 | String | true |
  | user_passwords | 借款密码 | String | true |
  | pro_id | 不懂 | String | true |
  | dev_id | 设备标识码 | String | true |
  | sms_code | 短信验证码 | String | false |

- 返回值:

  ```json
    {
      "code":"105",
      "error":"Incorrect user info ",
      "data": []
    }
  ```

#### 34. 更新默认电子钱包

- 接口地址: `/ElectronicWallet/save`

- 请求方式:  `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | eid | 电子钱包唯一id | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":{
        "token":""
     }
   }
  ```


#### 34. 更新默认银行卡

- 接口地址: `/Bank/update_bank`

- 请求方式:  `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | id | 银行卡id | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":{
        "token":""
     }
   }
  ```

#### 35. 获取还款数据

- 接口地址: `/repayIns/getRepaymentList`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | product_id | 产品id | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":{
        "payment_id":2,   // 1： SkyPay  2: PayCloos
        "oid":"2068767",
        "ad_id":"566581",
        "repay_time":1719244799,
        "use_days":"6",
        "money":"2000",
        "final_amount":2060,
        "current_amount":0,
        "repaid_amount":0,
        "ins_amount":null,
        "interest":0,
        "all_interest":60,
        "overtime_day":0,
        "overtime_price":0,
        "is_ins_repay":0,        // 是否支持分期 0 不支持 1 支持
        "is_instalment":0,      // 当前是否是多期，0 不是 1 是
        "is_normal_instalment":1,
        "pay_data": {   // 多期会有这个字段
          "back_time": 1719244799,
          "id": "",
          "interest":"",
          "money": "",
          "principal":""
        }
      }
    }
  ```

#### 36. 生成还款码

- 接口地址: `/repayIns/generateRepaymentCode`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | gid | 取款id 上个接口内的 ad_id | String | true |
  | type | 1：全还， 3：分期 | String | true |
  | cop_id | 优惠券id（分期产品传空字符串） | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":{
        "contract_number":"SKY DW31 0160 1355",
        "amount":1190,
        "mobile":"9000904878",
        "goid":"567162",
        "account_name":"SKYPAY\/FASTPAY"
      }
    }
  ```

#### 37. 生成还款条形码

- 接口地址: `/generatorIns/generateBarCode`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | g_id | 接口中的 goid | String | true |
  | type | 1：全还， 3：分期 | String | true |
  | c_id | 优惠券id（分期产品传空字符串） | String | true |

- 返回值:

  ```json
  {
    "code":"200",
    "error":"",
    "data":{
      "photo":"base64 字符串条形码"
    }
  }

  ```

#### 38. paycools 生成还款二维码

- 接口地址: `/RepayIns/qrcode`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | apd_id | 接口35中的 ad_id | String | true |
  | type | 1：全还， 3：分期 | String | true |
  | coupon_id | 优惠券id（分期产品传空字符串） | String | true |

- 返回值:

  ```json

  ```

#### 38. paycools 生成渠道url

- 接口地址: `/RepayIns/virtual`

- 请求方式: `Post`

- 请求参数:

  | 参数名称  | 说明 | 参数类型 | 是否必传 |
  | --- | --- | ---| --- |
  | apd_id | 接口35中的 ad_id | String | true |
  | type | 1：全还， 3：分期 | String | true |
  | coupon_id | 优惠券id（分期产品传空字符串） | String | true |
  | channel_code | gcash: GCASH_STATIC_VA, | String | true |

- 返回值:

  ```json
    {
      "code":"200",
      "error":"",
      "data":{
        "redirect_url":""
      }
    }
  ```

#### 39. 历史接圈

- 接口地址: `/LoanrecordIns/loan_list`

- 请求方式: `Post`

- 请求参数: 无

- 返回值:

  ```json
    {
      "code":"200",
      "error":"Success",
      "data":[
        {
          "pack_name":"Paghiram",
          "pack_img":"\/Public\/img\/CashPeso.png",
          "pid":"2",
          "back_time":"2024-06-24 23:59:59",
          "status":0,"price":2060
        },
        {
          "pack_name":"Happy Peso pro",
          "pack_img":"\/Public\/img\/HappyPesopro.png",
          "pid":"11","back_time":"2024-07-03 23:59:59",
          "status":0,
          "price":1190
        },
        {
          "pack_name":"Cash Peso pro",
          "pack_img":"\/Public\/img\/CashPesopro.png",
          "pid":"12",
          "back_time":"2024-07-17 23:59:59",
          "status":0,
          "price":1100
        }
      ]
    }
  ```


#### 21. 埋点接口

- 接口地址：`/Buriedpm/buried_info`

- 请求方式：`Post`

- 请求参数：无

- 返回值：

  ```json
  ```
unit API.Consts;

interface

uses
  System.SysUtils;

var
   fDataFullPath: string;


resourcestring
  Msg_WRONG_PW = 'The Password is invalid !! ';
  Msg_DataBase_NotFound = '·„ Ì „ «·⁄ÀÊ— ⁄·Ï „·› ﬁ«⁄œ… «·»Ì«‰« ';
  Msg_CloseAPP = 'Do you want to Close the Program ?';
  Msg_SucsseLogged = 'Logged in successfully !!';
  Msg_ErorrLogged = 'Logged in Erorr !!';
  Msg_DeleteRecord = 'Do You Confirm To Delete The Record';
  Msg_Delete = ' „ Õ–› »‰Ã«Õ';
  Msg_DeleteAll = 'Â·   ƒﬂœ ⁄·Ï ⁄„·Ì… «·Õœ› «·ﬂ·';
  Msg_NotFindRecord = 'Table Is Empyt!!';
  Msg_EditRecord = ' „ «· ⁄œÌ· «·ÊÀÌﬁ…';
  Msg_ErorrRecord = 'Ì—ÃÌ  ⁄»∆… «·»Ì«‰« ';
  Msg_AddRecord = ' „ «÷«›… «·ÊÀÌﬁ…';

  Msg_EmptyRecord = 'Empty Value, Enter it !!';
  Msg_UpdatedSuccesRecord = 'Record Updated Successfully';
  Msg_ErrorUpdatingRecord = 'Error Updating Record !!';
  Msg_ErrorRetrieving  = 'Error Retrieving Record !!';
  Msg_FieldExists = 'Error Field Already Exists !!';

  Msg_SuccesSent = 'Email Sent Successfully';
  Msg_ErrorUnknown = 'Unknown Error !!';

  Msg_ErrorEmpty = 'Empty Values, Enter it !!';

  Msg_AddedSuccesRecord = 'Record Added successfully';
  Msg_ErrorRecord = 'Error Record !!';
  Msg_Saved = 'Succes Saved!!';
  Msg_ErrorSaved = 'Error Saved  !!';

  Email_Subject_ResetPwd = '[GBank] Your Password Was Reset';

const
  DataFile = 'DB\GBank.db';

  slblWelcome_LOGININ     = 'Welcome Back , ';
  sSQL_LOGIN_All          = 'SELECT * FROM User';
  sSQL_LOGIN              = 'SELECT * FROM User WHERE Username =:U_USERNAME AND Password =:P_PASSWORD';
  sSQL_UserPerm_Type      = 'SELECT * FROM UserPermissions_Grp WHERE ID   =:P_PREUSERS' ;
  sSQL_Company            = 'SELECT * FROM Company WHERE ID   =:P_COMPANY' ;


  DateEn : array [1..12] of String = ('January', 'February', 'March', 'April', 'May', 'June', 'July',
                                       'August', 'September', 'October', 'November', 'December');
  DateFR : array [1..12] of String = ('Janvier', 'FÈvrier', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet',
                                       'Ao˚t', 'Septembre', 'Octobre', 'Novembre', 'DÈcembre');
  //REGEX /
  Email_REGEX       = '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';                 //Exp : Haithem.Nini20@Gmail.com
  Phone_REGEX       = ' ^(0)(5|6|7)(4|5|6|7)[0-9]{7}$';    // /^(00213|\+213|0)(5|6|7)[0-9]{8}$/    //Exp :  05xxxxxxxx Or 06xxxxxxxx Or 07xxxxxxxx
  AnyText_REGEX     = '^[a-zA-Z0-9 !@#$%^&*()_+\-=[\]{};:''",.<>/?`~|]+$';            //Exp :ABCa bc578()!@#$%^&*()_+\-=[\]{};:''",.
  NumbersOnly_REGEX = '^[0-9]+$' ;                //Exp :  0123456789999999
  ChartsOnly_REGEX  = '^[A-Za-z\s]+$';           //Exp :  AaIiYyPpNnzZ
  Username_REGEX    = '^[a-zA-Z_][a-zA-Z0-9_]{2,19}$';  //Exp :  user1 ,User_123, the_real_user, user_name_123, j_doe_456
  FristName_REGEX   = '^[A-Z][a-z]{1,19}$';        //Exp :  Elizabeth  ,William, Gabriel, Madeleine, Emma
  LastName_REGEX    = '^[A-Z][a-z''-]{1,19}$';     //Exp :  Hernandez  ,Garcia,  D'Angelo, Smith-Jones, Williams-Smith
  Password_REGEX    = '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';   //Exp :   Pa$$w0rd  ,myP@ssword1,  H0ld0n!2m3 , Hello123$, #3xamplePa$$word ,MySecr3tP@ssword
  Amaount_REGEX     = '^(0|[1-9]\d{0,10})(\.\d{1,2})?$';    //Exp : 87455.00 , 123,  84449444848.00 , 84848484.98

{$REGION '  kind LytMsg ...}
  IMGSuccess = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAACL0lEQVR42sWVy2sTURTGZ9DaRU3BRW3oSloUNRWy6F/QkFBBrKW+wKULG7soPrLMrt3UKqUUE1y4VKGN'+
               'CimUKto/oAvBR+wD6rapi4jRhYqd/k57BsbJJDMpDQ58nLnn8X137p17rmk0+DH/q4BlWc2YS2AARMERDZXAO/ACzJqm+atuAciFeBwc85nkF5BCJBdIAOIDmPtgRF0fwWPwChTVFwZxcB1E1DcJ7iL0'+
               '109gAnMH/FabcRe5JnNTJ9QEJshNVRWg4IKuq5CfI/m1EeChLoHJq0g/dfkKAZIOYQqgC9wg6VEQckd9EvMQrMmyUf/HLXAV8xR8AFEStgKQtmEGyc3qcr0Hp8FlfDNugWeYK7K5BKcCkr8BZ2QfqMng'+
               'u8X7A/CE8TW3wCrmuMyA4Gcf8g7MIjgBlkCCmm/4u3UFlhmfcguUMYdBiOCPesk1FsJ8B2V8rW4BIW0REYI/1TeEyTH+6rEscj5ixDYdHDUF/lkixsO8T+snxzTNJv8Eep3kyhFR4RViJ2tuMuOjSmiv'+
               'q6HkBSUvGq7Hb5MrflN87by/1V/P8CE/qLUyc8/f1POg4ZcOap/oOP5Slc2XtiJtxvugaZJnq8Af3kk2zY0q5H3GbquQw3aevDk75tXspHHdVhGxWZ9ml9R1lz40Sm7amVNPu14A6+qTZZQG52zXYyCN'+
               'gFVTwCF0EXPPCHbhyD3w3CsY5MqU6/Is6AGdGpIvkVM8D17u6crcr6fhAtvfQwQoIultTwAAAABJRU5ErkJggg==';

  IMGError  = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAAB5UlEQVR42sWVyStFcRTH7820wJOFshQpY1n4D0SUDBnL0sKwkWlpx8aUlCELS5SxKCF/gYVCxmItC5kW'+
              'iOdzOK+un8t7Ho9bn07vnPM739879/7Oz7ZC/Nj/KuD1eqMwVVAOORCvoUvYhkWYs237/tsCFJfCvZDkZ5Nn0InIfEACFA7DDECLuvZgEtbhXH2JkA/1kKm+IehA6MmfQD+mHR7UjpmLjM0064YioJ/c'+
              'zk8FWFCmfZXixSRvWAE8rCvALKtIKeuWPwiQFInZhxRoIGlC/Y2YeX5fGEUTMBX4x/V3E2YUTqRt+B9NgVrMNOxCDgnP+OTvj6gvzyeixTchW1qEf0zbtQMZUI1v1hSYwdTIyyU47FLoVUTT3/kcwq2Y'+
              'QZjCV2cKHGNSZQcED4xWOAtabsU1N0v9h/jTTYFrTCx4CN649NsnYrkV1zwP5gquicWZAreYaIgheBekgGxQNnpDzBOKFsmhk4N5hD/tz1/yTz/TcM1L++wz/elBk7EiY8b9oGlSsKOi0HobFXLYSli3'+
              '4ou5DTsZXG0qInbcz7Br0r7LHOomt8uZ851xvQan6pM2yoBzjuse6ELA+6WAQ6gS02cFduHIPbDgFgzkypTrsghyIVlD8k+2YBWWgroyf+sJucALwmgYKFMbDrAAAAAASUVORK5CYII=';

  IMGInfo  = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAABwklEQVR42sWVyyvEURTH55fXglF2liLltZiFf4EoeZRXWVpobOQxy9mxYUgWyMIS5VmjhD/BQiHPYm2l'+
             'DAvEz+dw1HT9Zn6/mTG59enUPY/vnfObe67ly/Ky/lXAtu0CTBd0QABK1PUAx7ANG5ZlvaQsQHEpPAllLoe8gxAim54EKJyDmYYh3TqDZTiAe90rhQboh1rdm4UxhN7dBCKYUXhVu2AmGYcZ1APlQYTY'+
             'UEIBEtq1r1K8heBDn4dFXiMmqiJt5EV/CRCUjzmHChggaMmhkP2VxHLwBTHzcCNtI+TNFOjFrMIpBAj4SFFA2nUCNdBNyLopsIbpkY+Lc85LaxxEhjEzsEKNPlPgGlMpJ8B5kaZAnXbgkhrVpkAMUwR+'+
             'nE8JCiRskfr9mEeIEVJsCkjRQhHB+ZwNAdcWeRCQSycX84qQKlPA9SN7EEj6kTP9m+Zqrpzc8W+a6UWTsSJjxvmiaVC6o6LJ9z0q5LK1krf743M6iQyuERURu+gy7ILad5lD48SG42NSGdf7cKt70kYZ'+
             'cPHjegLCCNhJBeKEOjFTPm8PjrwDW05OL0+mPJfNUA/l6pJfcgR7sJPWk/lXK+sCn86a5hnnCypmAAAAAElFTkSuQmCC';

  IMGWarn = 'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABmJLR0QA/wD/AP+gvaeTAAABp0lEQVR42sWVu0oDQRSGd/HWJJZiqwYxiSAIvoKXwiApAmJpJVpI0EpUiNh4QQRBG9uAWEREEPMKgo3X'+
            'IKTX0mhjlPE7OIFhzZrdmMWFjz+ZOef8u7MzZ20r4Mv+VwOlVBsyAWMwCB166hmu4Bxytm2/+zageBLZgq4aN1mEBUxyngwoLGNrsKSHbuEQ8vCkxzphGKYhJmmwDisYqVoGGWQZypCGfZI+XZ6yCZmD'+
            'TWiBDLGrrgYkJJATXXyc4Lzl4SJvFDmFZkiQd/bDgKBWvRwRmCHowEtxI38W2YNHiJNfdhqkkCNtMuC2LL8YyHJdQxRS5B87DbLIJMwzueunuFFD3tk2ZKkx5TQoIL0QY/K+ToN+/RQP1Ig6DUpICMJM'+
            'vvJf+Sluy/5UKszPFyjxt93NIMTkWxAGjViiOHIDBWr0OQ0Cf8mVbXpnfW/TD5/F5ZDJC5Y7r7pNzYOWJmDHp8EismG5HTQdVGkVcvfSKi48Fpd2Lq1CDlv1VmEEB9fsdJJbu5anKeqxHhix6mnXhlEw'+
            'HxyHifnJHIJuo+il9ZdPZqOuwA2+AA+f0BnbM66eAAAAAElFTkSuQmCC';
{$ENDREGION}

implementation

end.

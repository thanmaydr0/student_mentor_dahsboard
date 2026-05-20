function _defineProperty(obj, key, value) { key = _toPropertyKey(key); if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }
function _toPropertyKey(t) { var i = _toPrimitive(t, "string"); return "symbol" == typeof i ? i : String(i); }
function _toPrimitive(t, r) { if ("object" != typeof t || !t) return t; var e = t[Symbol.toPrimitive]; if (void 0 !== e) { var i = e.call(t, r || "default"); if ("object" != typeof i) return i; throw new TypeError("@@toPrimitive must return a primitive value."); } return ("string" === r ? String : Number)(t); }
const {
  Container,
  Row,
  Col,
  Button,
  Form,
  Card,
  InputGroup,
  Spinner,
  Img
} = ReactBootstrap;
import GoogleLoginButton from "./GoogleLoginButton.js";
import MicrosoftLoginButton from "./MicrosoftLoginButton.js";
const LoadingButtonComponent = ({
  className
}) => {
  return /*#__PURE__*/React.createElement(Button, {
    className: className,
    disabled: true
  }, /*#__PURE__*/React.createElement(Spinner, {
    as: "span",
    animation: "border",
    size: "sm",
    role: "status",
    "aria-hidden": "true"
  }), /*#__PURE__*/React.createElement("span", null, " Loading..."));
};
const LoginStatusMessageBlock = ({
  theme = 1,
  html = '',
  isSuccess = false
}) => {
  return html.trim() != '' && /*#__PURE__*/React.createElement("p", {
    className: "warningMsg" + (theme == 2 ? " alert alert-" + (isSuccess ? "success" : "danger") + " p-1" : ""),
    style: {
      color: isSuccess ? "var(--green)" : undefined
    },
    dangerouslySetInnerHTML: {
      __html: html
    }
  });
};
export default class LoginActionCardComponent extends React.Component {
  constructor(props) {
    super(props);
    // Functions
    _defineProperty(this, "handleChange", event => {
      console.log(event.target);
      let inputArr = this.state.inputArr;
      inputArr[event.target.name] = event.target.value;
      if (event.target.name == 'j_username') {
        window.gLoginStatus.userName = event.target.value;
      }
      if (event.target.name == 'j_otpType') {
        this.setState({
          loginBy: event.target.value
        });
      }
    });
    /*radioChange = (event) => {
    	this.setState({
    		loginBy: event.target.value
    	});
    }*/
    _defineProperty(this, "handleSubmit", event => {
      event.preventDefault();
      if (this.validate()) {
        let errorArr = {};
        errorArr["j_username"] = "";
        errorArr["capchaVerify"] = "";
        errorArr["j_password"] = "";
        errorArr["j_examRollNo"] = "";
        errorArr["j_phoneNo"] = "";
        errorArr["j_otpType"] = "";
        this.setState({
          errorArr: errorArr,
          isLoading: true
        });
        $('#form-sign-up').submit();
      }
    });
    _defineProperty(this, "forgetPassword", (e, isForget = true) => {
      e.preventDefault();
      e.stopPropagation();
      this.setState({
        isForget: isForget,
        warningMsg: '',
        isUsernameForget: false
      });
    });
    _defineProperty(this, "forgetUserName", (e, isUsernameForget = true) => {
      e.preventDefault();
      e.stopPropagation();
      this.setState({
        isUsernameForget: isUsernameForget,
        warningMsg: ''
      });
    });
    _defineProperty(this, "refreshImg", e => {
      var captchaImage = document.getElementById("captchaImage");
      var d = new Date();
      $("#captchaImage").attr("src", "imageCaptcha.jpg?" + d.getTime());
    });
    _defineProperty(this, "validate", () => {
      let inputArr = this.state.inputArr;
      let errorArr = {};
      let isValid = true;
      if (this.state.isUsernameForget == false && !inputArr["j_username"]) {
        isValid = false;
        errorArr["j_username"] = "Please enter your username.";
      }
      if (this.state.isUsernameForget == true && !inputArr["capchaVerify"] || this.state.isForget == true && inputArr["capchaVerify"] == undefined) {
        isValid = false;
        errorArr["capchaVerify"] = "Please enter Captcha.";
        this.refreshImg();
      }
      if (this.state.isUsernameForget == false && this.state.isForget == false && !inputArr["j_password"]) {
        isValid = false;
        errorArr["j_password"] = "Please enter your password.";
      }
      if (window.gLoginStatus.loginFormType == 'applicantReg' && window.gLoginStatus.loginWithOtp && !this.state.isOtpRequired && (this.state.loginBy == '' || this.state.loginBy == undefined)) {
        isValid = false;
        errorArr["j_otpType"] = "Please send otp on email or mobile.";
      }
      if (window.gLoginStatus.loginFormType == 'applicantReg' && window.gLoginStatus.loginWithOtp && !this.state.isOtpRequired && this.state.loginBy == 'mobileNo' && !inputArr["j_mobileOtp"]) {
        isValid = false;
        errorArr["j_mobileOtp"] = "Please enter mobile otp.";
      }
      if (window.gLoginStatus.loginFormType == 'applicantReg' && window.gLoginStatus.loginWithOtp && !this.state.isOtpRequired && this.state.loginBy == 'emailId' && !inputArr["j_emailOtp"]) {
        isValid = false;
        errorArr["j_emailOtp"] = "Please enter email otp.";
      }
      if (this.state.isUsernameForget == true && !inputArr["j_examRollNo"]) {
        isValid = false;
        errorArr["j_examRollNo"] = "Please enter your Exam Roll No.";
      }
      if (this.state.isUsernameForget == true && !inputArr["j_phoneNo"]) {
        isValid = false;
        errorArr["j_phoneNo"] = "Please enter your Mobile No.";
      }
      this.setState({
        errorArr: errorArr
      });
      return isValid;
    });
    _defineProperty(this, "showHide", e => {
      e.preventDefault();
      e.stopPropagation();
      this.setState({
        type: this.state.type === 'text' ? 'password' : 'text'
      });
    });
    _defineProperty(this, "isNumber", e => {
      const valueofText = e.target.value;
      var valueofText2 = valueofText.replace(/[^0-9]/, '');
      $('#' + e.target.id).val(valueofText2);
    });
    _defineProperty(this, "retrivePassword", e => {
      e.preventDefault();
      e.stopPropagation();
      if (this.validate()) {
        let errorArr = {};
        errorArr["j_username"] = "";
        this.setState({
          errorArr: errorArr,
          isLoading: true
        }, () => {
          this.sendPasswordLink();
        });
      }
    });
    _defineProperty(this, "sendPasswordLink", () => {
      const {
        formType
      } = this.props;
      var passwordResetUrl = '/restApi/resetUserPasswordLink.json';
      if (formType == 'aflUserReg' || formType == 'distanceStudent') {
        passwordResetUrl = 'resetPasswordForAffiliatedInstUser.json';
      }
      if (formType == 'guestRegForm') {
        passwordResetUrl = 'resetPasswordForGuestUser.json';
      }
      var url = window.location + "";
      $.ajax({
        url: passwordResetUrl,
        type: 'post',
        dataType: 'text',
        data: {
          username: this.state.inputArr.j_username.trim(),
          capecha: this.state.inputArr.capchaVerify.trim(),
          url: url,
          customerId: 1,
          formType: formType,
          applFormId: window.gLoginStatus.applFormId
        },
        success: function (messageTxt) {
          if (messageTxt == "<span style='color:red'>Please Enter Valid Captcha</span>" || messageTxt == "<span style='color:red'>The username " + this.state.inputArr.j_username.trim() + " is not registered with us.</span>") {
            this.refreshImg();
          }
          this.setState({
            warningMsg: messageTxt,
            isLoading: false
          });
        }.bind(this),
        error: function () {}
      });
    });
    _defineProperty(this, "retriveUserName", e => {
      e.preventDefault();
      e.stopPropagation();
      if (this.validate()) {
        let errorArr = {};
        errorArr["j_examRollNo"] = "";
        errorArr["j_phoneNo"] = "";
        this.setState({
          errorArr: errorArr,
          isLoading: true
        }, () => {
          this.sendUserName();
        });
      }
    });
    _defineProperty(this, "sendUserName", () => {
      $.ajax({
        url: '/restApi/getPVTStudEmailForExam.json',
        type: 'post',
        dataType: 'text',
        data: {
          examRollNo: this.state.inputArr.j_examRollNo.trim(),
          mobileNumber: this.state.inputArr.j_phoneNo.trim()
        },
        beforeSend: function () {},
        complete: function () {},
        success: function (userEmail) {
          this.setState({
            userEmail: userEmail,
            isLoading: false,
            isUserNameExist: userEmail.length > 0 ? 'isExist' : 'isNotExist'
          });
          console.log(" isUserNameExist " + this.state.isUserNameExist);
        }.bind(this),
        error: function () {}
      });
    });
    _defineProperty(this, "handleBlur", () => {
      if (this.state.inputArr.j_username != "" && this.state.inputArr.j_username != undefined) {
        this.fetchLoginDetails();
      }
    });
    _defineProperty(this, "fetchLoginDetails", () => {
      fetch(`restApi/fetchLoginDetails.json?userName=${this.state.inputArr.j_username.trim()}`).then(res => res.json()).then(res => {
        this.setState({
          email: res[0][0].email,
          mobileNo: res[0][0].mobileNo,
          firstName: res[0][0].firstName,
          cuId: res[0][0].cuId,
          isOtpRequired: res[0][0].isOtpRequired
        });
      });
    });
    _defineProperty(this, "maskEmail", email => {
      const [name, domain] = email.split("@");
      if (name.length <= 4) {
        return name[0] + "*".repeat(name.length - 1) + "@" + domain;
      }
      const maskedName = name.slice(0, 2) + "*".repeat(name.length - 4) + name.slice(-2);
      return maskedName + "@" + domain;
    });
    _defineProperty(this, "maskPhone", phone => {
      return phone.slice(0, 2) + '*'.repeat(phone.length - 4) + phone.slice(-2);
    });
    this.state = {
      inputArr: {},
      errorArr: {},
      type: "password",
      isForget: false,
      isUsernameForget: false,
      isUserNameExist: '0',
      isLoading: false,
      isSSO: false,
      loginBy: '',
      mobileNo: '',
      email: '',
      firstName: '',
      cuId: '',
      isOtpRequired: false
    };
  }
  render() {
    const {
      regArray = [],
      warningMsg = '',
      isBrowserError = false,
      isSSO = false,
      FooterComponent,
      showQrLoginLink = false,
      onQrLoginClick,
      theme = 1,
      formType = 'login',
      ssoAuthenticationProvider,
      ssoOnlyLogin = false
    } = this.props;
    const {
      warningMsg: warningMsgState = ''
    } = this.state;
    const isForgotPasswordOptionEnabled = window.gLoginStatus.showForgotPasswordOption !== false;
    const isSsoOnlyLogin = ssoOnlyLogin === true || ssoOnlyLogin === "true";
    var resetPwdStatus = warningMsgState.includes('Password reset link has been sent');
    console.log("warningMsg", warningMsg);
    const cssstyle = {
      display: "block",
      marginBottom: ".1rem"
    };
    let isSSOM;
    let ForGetPassWord;
    let buttonClsName = "btn " + gLoginStatus.btnCls + " btn-block customB mt-3";
    let buttonSuccessClsName = "btn btn-success btn-block customB mt-3";
    if (isSSO) {
      isSSOM = /*#__PURE__*/React.createElement("span", null, "Sign with ", /*#__PURE__*/React.createElement("img", {
        style: {
          width: '100px',
          height: '50px'
        },
        src: "img/MicrosoftAzure.png"
      }));
    } else {
      ForGetPassWord = /*#__PURE__*/React.createElement("div", {
        className: "forgot-password",
        style: {
          cursor: 'pointer',
          marginBottom: theme == 2 ? '1.3rem' : undefined
        }
      }, formType != 'login' && this.state.isForget && !this.state.isUsernameForget && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetPassword(e, false)
      }, "Go back to login"), formType == 'login' && this.state.isForget && !this.state.isUsernameForget && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetPassword(e, false)
      }, "Go back to login"), formType != 'login' && !this.state.isForget && this.state.isUsernameForget && formType == 'aflUserReg' && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetUserName(e, false)
      }, "Go back to login"), formType != 'login' && isForgotPasswordOptionEnabled && !window.gLoginStatus.showForgotPasswordBtn && this.state.isForget != true && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetPassword(e)
      }, "Forgot password?"), formType == 'login' && isForgotPasswordOptionEnabled && this.state.isForget != true && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetPassword(e)
      }, "Forgot password?"), formType != 'login' && this.state.isUsernameForget != true && formType == 'aflUserReg' && /*#__PURE__*/React.createElement(Button, {
        className: theme == 1 ? "text-white" : "",
        variant: "link",
        size: "sm",
        onClick: e => this.forgetUserName(e)
      }, "Forgot username?"));
    }
    var actionUrl = "/j_spring_security_check";
    if (formType == 'applicantReg') {
      actionUrl = `/applicantUserLoginCheck?applFormId=${window.gLoginStatus.applFormId}`;
    }
    if (formType == 'aflUserReg' || formType == 'distanceStudent') {
      actionUrl = '/aflStudentLoginCheck';
    }
    if (formType == 'guestRegForm') {
      actionUrl = '/guestUserLoginCheck';
    }
    if (formType == 'applicantRegKuk') {
      actionUrl = '/applicantUserLoginCheck';
    }
    return /*#__PURE__*/React.createElement(Card, {
      className: "mb-2",
      style: {
        height: '98.6%'
      }
    }, /*#__PURE__*/React.createElement(Card.Header, null, formType == 'applicantReg' || formType == 'aflUserReg' || formType == 'distanceStudent' || formType == 'guestRegForm' || formType == 'applicantRegKuk' ? /*#__PURE__*/React.createElement("h6", null, /*#__PURE__*/React.createElement("b", null, "Already Registered, Sign in/Login here")) : /*#__PURE__*/React.createElement("h6", null, /*#__PURE__*/React.createElement("b", null, "Welcome! Please login to continue."))), /*#__PURE__*/React.createElement(Card.Body, null, /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement(LoginStatusMessageBlock, {
      html: warningMsg,
      theme: theme,
      isSuccess: false
    }), /*#__PURE__*/React.createElement(LoginStatusMessageBlock, {
      html: warningMsgState,
      theme: theme,
      isSuccess: true
    }), isSSOM), !isBrowserError && /*#__PURE__*/React.createElement("div", null, globalThis.gLoginStatus.isSSOEnabled == "true" && ssoAuthenticationProvider?.toUpperCase() == "GOOGLE" && window.location.href.includes("/login.htm") && /*#__PURE__*/React.createElement(GoogleLoginButton, {
      displayOr: !isSsoOnlyLogin
    }), globalThis.gLoginStatus.isSSOEnabled == "true" && ssoAuthenticationProvider?.toUpperCase() == "MICROSOFT" && window.location.href.includes("/login.htm") && /*#__PURE__*/React.createElement(MicrosoftLoginButton, null), !isSsoOnlyLogin && /*#__PURE__*/React.createElement(Form, {
      id: "form-sign-up",
      action: actionUrl,
      method: "post",
      onSubmit: this.handleSubmit
    }, this.state.isUsernameForget ? /*#__PURE__*/React.createElement("div", null) : /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement(Form.Group, {
      controlId: "username"
    }, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      type: "text",
      autoFocus: true,
      defaultValue: this.state.inputArr.j_username,
      onChange: this.handleChange,
      onBlur: window.gLoginStatus.loginWithOtp && formType == 'applicantReg' ? this.handleBlur : '',
      className: "form-control",
      name: "j_username",
      id: "j_username",
      placeholder: window.gLoginStatus.showForgotPasswordBtn && formType == 'applicantReg' ? "Enter application number" : "Enter username"
    })), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_username), this.state.isForget && /*#__PURE__*/React.createElement("div", {
      style: {
        paddingTop: '10px'
      }
    }, " ", /*#__PURE__*/React.createElement(Row, null, /*#__PURE__*/React.createElement(Col, {
      className: "col-8"
    }, /*#__PURE__*/React.createElement("img", {
      src: "imageCaptcha.jpg",
      id: "captchaImage"
    })), /*#__PURE__*/React.createElement(Col, {
      className: "col-4"
    }, /*#__PURE__*/React.createElement("a", {
      onClick: e => this.refreshImg(e),
      style: {
        cursor: 'pointer'
      }
    }, /*#__PURE__*/React.createElement("i", {
      className: "fa fa-refresh"
    }), " Refresh"))), /*#__PURE__*/React.createElement("div", {
      style: {
        paddingTop: '10px'
      }
    }, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      type: "text",
      autoFocus: true,
      defaultValue: this.state.inputArr.capchaVerify,
      onChange: this.handleChange,
      className: "form-control input-group forgetForm",
      name: "capchaVerify",
      id: "capchaVerify",
      placeholder: "Enter Captcha"
    }))), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.capchaVerify), " "))), this.state.isForget || this.state.isUsernameForget ? /*#__PURE__*/React.createElement("div", null) : /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement(Form.Group, null, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      type: this.state.type,
      defaultValue: this.state.inputArr.j_password,
      onChange: this.handleChange,
      name: "j_password",
      id: "password-1",
      className: "form-control input-group forgetForm",
      placeholder: window.gLoginStatus.showForgotPasswordBtn && formType == 'applicantReg' ? "Enter date of birth" : "Enter password"
    }), /*#__PURE__*/React.createElement(InputGroup.Prepend, null, /*#__PURE__*/React.createElement("span", {
      className: "input-group-text"
    }, /*#__PURE__*/React.createElement("i", {
      className: "pw-visible-click fa " + (this.state.type == 'text' ? "fa-eye" : "fa-eye-slash"),
      onClick: e => this.showHide(e),
      "aria-hidden": "true"
    })))), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_password))), formType == 'applicantReg' && window.gLoginStatus.loginWithOtp && !this.state.isOtpRequired && /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement(Form.Group, null, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      as: "select",
      defaultValue: this.state.inputArr.j_otpType,
      onChange: this.handleChange,
      className: "form-control input-group forgetForm",
      name: "j_otpType",
      style: {
        fontSize: 'small'
      }
    }, /*#__PURE__*/React.createElement("option", {
      value: ""
    }, "Send OTP on"), this.state.mobileNo != "" && this.state.mobileNo != undefined && /*#__PURE__*/React.createElement("option", {
      value: "mobileNo"
    }, this.maskPhone(this.state.mobileNo)), this.state.email != "" && this.state.email != undefined && /*#__PURE__*/React.createElement("option", {
      value: "emailId"
    }, this.maskEmail(this.state.email)))), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_otpType))), formType == 'applicantReg' && window.gLoginStatus.loginWithOtp && /*#__PURE__*/React.createElement(Row, {
      className: ""
    }, /*#__PURE__*/React.createElement(Col, {
      xs: 6,
      lg: 6,
      md: 6,
      style: {
        maxWidth: "39%",
        marginLeft: "5px"
      }
    }, /*#__PURE__*/React.createElement(LoginOtpSendButtonComponent, {
      username: this.state.inputArr.j_username,
      otpType: this.state.loginBy,
      email: this.state.email,
      mobile: this.state.mobileNo,
      firstName: this.state.firstName,
      cuId: this.state.cuId
    })), /*#__PURE__*/React.createElement(Col, {
      xs: 6,
      lg: 6,
      md: 6
    }, /*#__PURE__*/React.createElement(Form.Group, {
      className: ""
    }, this.state.loginBy === "mobileNo" && /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      className: "mobile_otp",
      type: "text",
      value: this.state.inputArr.j_mobileOtp,
      onChange: this.handleChange,
      name: "j_mobileOtp",
      placeholder: "Enter Mobile OTP",
      autoComplete: "otp",
      style: {
        maxWidth: "100%"
      }
    })), this.state.errorArr.j_mobileOtp && /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_mobileOtp), this.state.inputArr.j_otpType === "emailId" && /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      className: "email_otp",
      type: "text",
      defaultValue: this.state.inputArr.j_emailOtp,
      onChange: this.handleChange,
      name: "j_emailOtp",
      placeholder: "Enter Email OTP",
      autoComplete: "otp",
      style: {
        maxWidth: "100%"
      }
    })), this.state.errorArr.j_emailOtp && /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_emailOtp)))), !this.state.isUsernameForget ? /*#__PURE__*/React.createElement("div", null) : /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement(Form.Group, null, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      type: "text",
      defaultValue: this.state.inputArr.j_examRollNo,
      onChange: this.handleChange,
      name: "j_examRollNo",
      maxLength: "20",
      id: "examRollNo",
      className: "form-control input-group forgetForm",
      placeholder: "Enter Exam Roll Number"
    })), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_examRollNo)), /*#__PURE__*/React.createElement(Form.Group, null, /*#__PURE__*/React.createElement(InputGroup, null, /*#__PURE__*/React.createElement(Form.Control, {
      type: "text",
      defaultValue: this.state.inputArr.j_phoneNo,
      onChange: this.handleChange,
      maxLength: "10",
      name: "j_phoneNo",
      onKeyUp: this.isNumber,
      id: "phoneNo",
      className: "form-control input-group forgetForm",
      placeholder: "Enter Mobile Number"
    })), /*#__PURE__*/React.createElement("span", {
      className: "text-danger warningMsg"
    }, this.state.errorArr.j_phoneNo))), theme == 2 && ForGetPassWord, !this.state.isUsernameForget && (this.state.isForget ? this.state.isLoading ? /*#__PURE__*/React.createElement(LoadingButtonComponent, {
      className: buttonClsName
    }) : /*#__PURE__*/React.createElement("button", {
      type: "submit",
      onClick: e => this.retrivePassword(e),
      className: resetPwdStatus ? buttonSuccessClsName : buttonClsName
    }, resetPwdStatus ? "Send Again" : "Reset Password") : this.state.isLoading ? /*#__PURE__*/React.createElement(LoadingButtonComponent, {
      className: buttonClsName
    }) : /*#__PURE__*/React.createElement("button", {
      type: "submit",
      className: buttonClsName
    }, "Login")), this.state.isUsernameForget && /*#__PURE__*/React.createElement("button", {
      type: "submit",
      onClick: e => this.retriveUserName(e),
      className: buttonClsName
    }, "Submit"), formType == 'login' && this.state.isForget != true && !this.state.isUsernameForget && showQrLoginLink && /*#__PURE__*/React.createElement("div", {
      className: "forgot-password",
      style: {
        cursor: 'pointer'
      }
    }, /*#__PURE__*/React.createElement(Button, {
      className: theme == 1 ? "text-white" : "",
      variant: "link",
      size: "sm",
      onClick: e => {
        e.preventDefault();
        e.stopPropagation();
        if (onQrLoginClick) {
          onQrLoginClick();
        }
      }
    }, "Login with QR")), this.state.isUsernameForget && (this.state.isUserNameExist == '0' ? /*#__PURE__*/React.createElement("span", null) : this.state.isUserNameExist == 'isExist' ? /*#__PURE__*/React.createElement("span", null, "UserName : ", this.state.userEmail) : /*#__PURE__*/React.createElement("span", null, "UserName not available for entered exam roll no. & mobile no."))), theme == 1 && /*#__PURE__*/React.createElement("br", null), !isSsoOnlyLogin && theme == 1 && ForGetPassWord, isForgotPasswordOptionEnabled && isSsoOnlyLogin && /*#__PURE__*/React.createElement("a", {
      href: "https://ssp.srmist.edu.in/resetpassword/"
    }, "Forgot password?"))), /*#__PURE__*/React.createElement(Card.Footer, {
      className: "text-muted text-center"
    }, regArray.map(function (obj, i) {
      return /*#__PURE__*/React.createElement("label", {
        style: cssstyle,
        key: i
      }, /*#__PURE__*/React.createElement("a", {
        href: obj.link
      }, obj.linkType));
    }), FooterComponent != undefined && FooterComponent));
  }
}
class LoginOtpSendButtonComponent extends React.Component {
  constructor(props) {
    super(props);
    _defineProperty(this, "sendLoginOTP", () => {
      if (window.gLoginStatus.userName !== undefined && window.gLoginStatus.userName !== "") {
        var paramData = {
          username: window.gLoginStatus.userName,
          otpType: this.props.otpType,
          email: this.props.email,
          mobile: this.props.mobile,
          firstName: this.props.firstName,
          applFormId: window.gLoginStatus.applFormId,
          cuId: this.props.cuId
        };
        this.setState({
          loginOtpProcessing: true,
          loginOtpSent: true,
          otpDisabled: true,
          otpTimer: 120 // 2 minutes countdown
        }, () => {
          $.ajax({
            url: '/anon_applLoginOtp.json',
            data: paramData,
            type: 'POST',
            dataType: 'json',
            success: function (res) {
              if (res.isError) {
                this.setState({
                  loginOtpSent: false,
                  loginOtpProcessing: false,
                  otpDisabled: false
                });
              } else {
                this.setState({
                  loginOtpProcessing: false,
                  loginOtpSent: true,
                  loginOtpMessage: res.otp_no
                });
                this.startOTPTimer();
              }
            }.bind(this)
          });
        });
      }
    });
    _defineProperty(this, "startOTPTimer", () => {
      if (this.timer) clearInterval(this.timer);
      this.timer = setInterval(() => {
        if (this.state.otpTimer > 0) {
          this.setState(prevState => ({
            otpTimer: prevState.otpTimer - 1
          }));
        } else {
          clearInterval(this.timer);
          this.setState({
            otpDisabled: false
          });
        }
      }, 1000);
    });
    _defineProperty(this, "formatTime", seconds => {
      const minutes = Math.floor(seconds / 60);
      const secs = seconds % 60;
      return `${minutes}.${secs < 10 ? '0' : ''}${secs} s`;
    });
    this.state = {
      loginOtpSent: false,
      loginOtpProcessing: false,
      loginOtp: '',
      otpTimer: 0,
      // Timer in seconds
      otpDisabled: false
    };
    this.timer = null;
  }
  componentWillUnmount() {
    clearInterval(this.timer);
  }
  render() {
    return /*#__PURE__*/React.createElement("div", null, !this.state.loginOtpSent && this.props.otpType != '' && /*#__PURE__*/React.createElement(Button, {
      className: "btn-block",
      size: "sm",
      onClick: this.sendLoginOTP,
      disabled: this.state.loginOtpProcessing
    }, "Send OTP"), this.state.loginOtpProcessing && /*#__PURE__*/React.createElement("p", {
      className: "text-primary small"
    }, /*#__PURE__*/React.createElement("i", {
      className: "fa fa-circle-o-notch fa-spin fa-lg fa-fw"
    }), " Sending..."), this.state.loginOtpSent && !this.state.loginOtpProcessing && /*#__PURE__*/React.createElement("p", {
      className: "text-success small"
    }, this.state.loginOtpMessage), this.state.loginOtpSent && /*#__PURE__*/React.createElement("a", {
      href: "#",
      className: "btn-block",
      size: "sm",
      style: {
        color: "#0e3e88",
        fontSize: "12px",
        marginLeft: "1px",
        cursor: this.state.otpDisabled ? "not-allowed" : "pointer",
        opacity: this.state.otpDisabled ? 0.5 : 1
      },
      onClick: e => {
        e.preventDefault();
        if (!this.state.otpDisabled) this.sendLoginOTP();
      }
    }, this.state.otpDisabled ? `Resend OTP in ${this.formatTime(this.state.otpTimer)}` : "Resend OTP"));
  }
}
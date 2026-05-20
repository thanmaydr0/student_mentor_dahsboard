function _defineProperty(obj, key, value) { key = _toPropertyKey(key); if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }
function _toPropertyKey(t) { var i = _toPrimitive(t, "string"); return "symbol" == typeof i ? i : String(i); }
function _toPrimitive(t, r) { if ("object" != typeof t || !t) return t; var e = t[Symbol.toPrimitive]; if (void 0 !== e) { var i = e.call(t, r || "default"); if ("object" != typeof i) return i; throw new TypeError("@@toPrimitive must return a primitive value."); } return ("string" === r ? String : Number)(t); }
import Footer from './layout/FooterModule.js';
import LoginActionCardComponent from './LoginActionCardComponent.js';
import RegistrationActionCardComponent from './RegistrationActionCardComponent.js';
import AffiliatedStudentRegistrationComponent from './AffiliatedStudentRegistrationComponent.js';
//import RegistrationActionCardComponent from './RegistrationActionStepsCardComponent.js';
import RegistrationPageForKUKComponent from './RegistrationPageForKUKComponent.js';
const {
  Container,
  Row,
  Col,
  Button,
  Alert,
  Card
} = ReactBootstrap;
const RawHTML = ({
  children,
  className = ""
}) => /*#__PURE__*/React.createElement("div", {
  className: className,
  dangerouslySetInnerHTML: {
    __html: children
  }
});
class LoginPageComponent extends React.Component {
  constructor(props) {
    super(props);
    _defineProperty(this, "toggleLoginAndRegistraionPage", () => {
      this.setState({
        isLoginView: !this.state.isLoginView
      });
    });
    _defineProperty(this, "openInlineQrPanel", () => {
      this.setState({
        showInlineQrPanel: true
      }, () => {
        if (globalThis.WebQrLogin) {
          if (globalThis.WebQrLogin.setOnExpire) {
            globalThis.WebQrLogin.setOnExpire(this.closeInlineQrPanel);
          }
          globalThis.WebQrLogin.generate();
        }
      });
    });
    _defineProperty(this, "closeInlineQrPanel", () => {
      if (globalThis.WebQrLogin) {
        globalThis.WebQrLogin.close();
      }
      this.setState({
        showInlineQrPanel: false
      });
    });
    const {
      formType = 'login',
      customerUID = ''
    } = this.props;
    console.log(customerUID);
    var gLoginStatus = window.gLoginStatus != undefined ? window.gLoginStatus : {};
    const {
      theme = 1
    } = gLoginStatus;
    this.state = {
      regArray: [],
      footerArr: [],
      LoginHeader: "JUNOCampus",
      BannerPosition: "",
      BannerText: "",
      warningMsg: gLoginStatus.message,
      isBrowserError: gLoginStatus.isBrowserError,
      isForget: false,
      isLoading: false,
      isSSO: false,
      viewLogoOnBanner: true,
      bannerTextBackgTra: '0.58',
      isLoginView: true,
      theme: theme,
      customerUID: '',
      instName: '',
      instLogo: '',
      trustName: '',
      trustLogo: '',
      bannerLogo: '',
      ssoAuthenticationProvider: '',
      ssoOnlyLogin: false,
      customLogoPath: '',
      showInlineQrPanel: false
    };
  }
  fetchLoginPageConfiguration() {
    $.ajax({
      url: 'getLoginPageConfiguration.json',
      dataType: 'json',
      type: 'GET',
      success: function (configObj) {
        this.setState({
          isLoaded: true,
          regArray: configObj.regArr,
          footerArr: configObj.footerArr,
          LoginHeader: decodeURIComponent(configObj.loginHeader),
          BannerText: decodeURIComponent(configObj.bannerText),
          isSSO: configObj.isSSO,
          BannerPosition: configObj.bannerPosition,
          viewLogoOnBanner: configObj.viewLogoOnBanner,
          BannerTextBackgTra: configObj.bannerTextBackgTra,
          customerUID: configObj.customerUID,
          bannerLogo: configObj.bannerLogo,
          ssoAuthenticationProvider: configObj?.ssoAuthProvider || "",
          ssoOnlyLogin: configObj?.ssoOnlyLogin === true || configObj?.ssoOnlyLogin === "true"
        });
        window.gLoginStatus = Object.assign({}, window.gLoginStatus, {
          clientId: configObj?.ssoClientId,
          ssoAuthenticationProvider: configObj?.ssoAuthProvider,
          tenantId: configObj?.tenantId,
          ssoOnlyLogin: configObj?.ssoOnlyLogin === true || configObj?.ssoOnlyLogin === "true"
        });
        if (this.state.theme == 1) {
          $('body').css({
            'background-image': 'url(' + configObj.bannerUrl + ')',
            'background-position': this.state.bannerPosition
          });
        }
      }.bind(this),
      error: function () {}
    });
  }
  componentDidMount() {
    this.fetchLoginPageConfiguration();
    if (globalThis.WebQrLogin && globalThis.WebQrLogin.setOnExpire) {
      globalThis.WebQrLogin.setOnExpire(this.closeInlineQrPanel);
    }
    if (window.gLoginStatus.serverHelper == "DYPATIL_SERVER") {
      this.fetchInstituteDetails();
    }
  }
  componentWillUnmount() {
    if (globalThis.WebQrLogin && globalThis.WebQrLogin.setOnExpire) {
      globalThis.WebQrLogin.setOnExpire(null);
    }
  }
  fetchInstituteDetails() {
    $.ajax({
      url: 'restApi/getInstituteDetailsFormId.json',
      dataType: 'json',
      data: {
        applFormId: window.gLoginStatus.applFormId
      },
      type: 'GET',
      success: function (jArray) {
        this.setState({
          instName: jArray[0][0]["instName"],
          instLogo: jArray[0][0]["instLogo"],
          trustName: jArray[0][0]["trustName"],
          trustLogo: jArray[0][0]["trustLogo"],
          customLogoPath: jArray[0][0]["logoPath"]
        });
        if (this.state.theme == 1) {
          $('body').css({
            'background-image': 'url(' + configObj.bannerUrl + ')',
            'background-position': this.state.bannerPosition
          });
        }
      }.bind(this),
      error: function () {}
    });
  }
  render() {
    const {
      regArray,
      LoginHeader,
      viewLogoOnBanner = true,
      BannerTextBackgTra = '0.58',
      BannerText,
      footerArr,
      isLoginView,
      theme = 1,
      customerUID,
      instName,
      instLogo,
      trustName,
      trustLogo,
      bannerLogo,
      customLogoPath,
      ssoOnlyLogin
    } = this.state;
    const {
      formType = 'login',
      studType,
      isRegWindow = 'true'
    } = this.props;
    var megheTrust = '';
    if (customerUID == "2b03f144-5941-219d-93e6-9457a56d2858" && (trustName == 'DATTA MEGHE INSTITUTE OF HIGHER EDUCATION AND RESEARCH TRUST' || trustName == '')) {
      megheTrust = 'Datta Meghe Institute of Higher Education and Research (DU)';
    }
    const showTopHeader = theme == 2;
    const {
      isGuidelinesShow = false,
      webQrLoginEnabled = false
    } = window.gLoginStatus != undefined ? window.gLoginStatus : {};
    const loginHeaderNew = `<h2 class="qrShPb pXs6bb PZPZlf q8U8x aTI8gc hNKfZe" data-attrid="title" data-dtype="d3ifr" data-local-attribute="d3bn" data-ved="2ahUKEwiLx5jQyfX_AhXgtlYBHQeCCoEQ3B0oAXoECF8QAg">
								<span>${megheTrust != '' ? megheTrust : instName}</span></h2>
								<h1>
									&nbsp;</h1>
								<p>
									&nbsp;</p>`;
    const isDypServer = window.gLoginStatus.serverHelper === 'DYPATIL_AKURDI_SERVER';
    return /*#__PURE__*/React.createElement("div", {
      className: "wrapper",
      style: {
        paddingTop: showTopHeader ? 'initial' : '5%'
      }
    }, /*#__PURE__*/React.createElement("div", {
      className: "content"
    }, showTopHeader && /*#__PURE__*/React.createElement("div", {
      className: window.gLoginStatus.serverHelper == "XLRI_SERVER" ? 'top-header-branding-new' : 'top-header-branding'
    }, /*#__PURE__*/React.createElement("hr", null), customLogoPath == '' && /*#__PURE__*/React.createElement("img", {
      id: "logo",
      src: customerUID == "2b03f144-5941-219d-93e6-9457a56d2858" ? "getCustomerLogo.json?imgSrc=" + trustLogo : "getCustomerLogo.json"
    }), customerUID == "73861c5a-5941-11e5-9b54-000d3aa07e51" && customLogoPath != '' && window.gLoginStatus.applFormId != '' && /*#__PURE__*/React.createElement("img", {
      id: "logo",
      src: "restApi/getCustomLogo.json?applFormId1=" + window.gLoginStatus.applFormId
    })), formType == 'aflUserReg' && studType == 'pvtStud' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text sub-head"
    }, 'PRIVATE CANDIDATE EXAMINATION FORM')), formType == 'aflUserReg' && studType == 'aflStud' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), customerUID == "06951e0b-5941-219d-11e5-80ee733292a6" && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text sub-head"
    }, 'ENROLLED STUDENT PORTAL'), customerUID != "06951e0b-5941-219d-11e5-80ee733292a6" && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text sub-head"
    }, 'AFFILIATED STUDENT PORTAL')), formType == 'distanceStudent' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text sub-head"
    }, 'DISTANCE STUDENT ADMISSION FORM', " ")), formType == 'guestRegForm' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text sub-head"
    }, 'GUEST USER PORTAL', " ")), formType == 'applicantReg' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, customerUID == "2b03f144-5941-219d-93e6-9457a56d2858" ? loginHeaderNew : LoginHeader)), formType == 'applicantRegKuk' && /*#__PURE__*/React.createElement("div", {
      className: "top-header-branding-text"
    }, /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader)), /*#__PURE__*/React.createElement(Container, {
      className: "leftContent jumbotron",
      style: {
        backgroundColor: theme == 1 ? 'rgba(0,0,0, ' + BannerTextBackgTra + ')' : undefined,
        paddingTop: '15px',
        paddingBottom: '15px'
      }
    }, /*#__PURE__*/React.createElement(Row, null, formType == 'login' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, webQrLoginEnabled && this.state.showInlineQrPanel ? /*#__PURE__*/React.createElement("div", {
      style: {
        width: '100%',
        minHeight: '360px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }
    }, /*#__PURE__*/React.createElement("div", {
      style: {
        textAlign: 'center'
      }
    }, /*#__PURE__*/React.createElement("div", {
      id: "webQrLoginQrCode",
      style: {
        display: 'inline-block',
        minHeight: '220px'
      }
    }), /*#__PURE__*/React.createElement("div", {
      style: {
        marginTop: '8px'
      }
    }, /*#__PURE__*/React.createElement("div", {
      id: "webQrLoginStatus"
    }), /*#__PURE__*/React.createElement("div", null, "Expires in: ", /*#__PURE__*/React.createElement("span", {
      id: "webQrLoginCountdown"
    }, "-"))), /*#__PURE__*/React.createElement("div", {
      style: {
        marginTop: '8px'
      }
    }, /*#__PURE__*/React.createElement(Button, {
      variant: "link",
      size: "sm",
      onClick: this.closeInlineQrPanel
    }, "Hide QR")))) : /*#__PURE__*/React.createElement(React.Fragment, null, viewLogoOnBanner == true && /*#__PURE__*/React.createElement("img", {
      style: {
        height: '120px',
        padding: '1%'
      },
      id: "logo",
      src: bannerLogo
    }), /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), /*#__PURE__*/React.createElement("div", {
      className: "toHide"
    }, /*#__PURE__*/React.createElement(RawHTML, null, BannerText)))), formType == 'aflUserReg' && studType == 'aflStud' && isRegWindow == 'false' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, viewLogoOnBanner == true && /*#__PURE__*/React.createElement("img", {
      style: {
        height: '120px',
        padding: '1%'
      },
      id: "logo",
      src: "getCustomerLogo.json"
    }), /*#__PURE__*/React.createElement(RawHTML, null, LoginHeader), /*#__PURE__*/React.createElement("div", {
      className: "toHide"
    }, /*#__PURE__*/React.createElement(RawHTML, null, BannerText))), isGuidelinesShow && formType == 'applicantReg' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 12,
      lg: 12,
      sm: 12
    }, /*#__PURE__*/React.createElement(Card, {
      className: "mb-4"
    }, /*#__PURE__*/React.createElement(Card.Header, null, /*#__PURE__*/React.createElement("i", {
      className: "fa fa-question-circle-o pull-right",
      "aria-hidden": "true"
    }), /*#__PURE__*/React.createElement("h6", null, /*#__PURE__*/React.createElement("b", null, "Guidelines"))), /*#__PURE__*/React.createElement(Card.Body, null, /*#__PURE__*/React.createElement("div", {
      dangerouslySetInnerHTML: {
        __html: decodeURIComponent(labelProps.regPageGuidelines)
      }
    })))), formType === 'applicantReg' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      sm: 12,
      md: 8,
      lg: isDypServer ? 4 : 8
    }, !isDypServer && /*#__PURE__*/React.createElement(RegistrationActionCardComponent, {
      formType: formType,
      customerUID: customerUID
    })), formType == 'aflUserReg' && studType == 'pvtStud' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, /*#__PURE__*/React.createElement(RegistrationActionCardComponent, {
      formType: formType,
      customerUID: customerUID
    })), formType == 'aflUserReg' && studType == 'aflStud' && isRegWindow == 'true' && /*#__PURE__*/React.createElement(Col, {
      id: customerUID,
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, /*#__PURE__*/React.createElement(AffiliatedStudentRegistrationComponent, {
      formType: formType,
      customerUID: customerUID,
      isRegWindow: isRegWindow
    })), formType == 'distanceStudent' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, /*#__PURE__*/React.createElement(RegistrationActionCardComponent, {
      formType: formType,
      customerUID: customerUID
    })), formType == 'guestRegForm' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, /*#__PURE__*/React.createElement(RegistrationActionCardComponent, {
      formType: formType,
      customerUID: customerUID
    })), formType == 'applicantRegKuk' && /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 8,
      lg: 8,
      sm: 12
    }, /*#__PURE__*/React.createElement(RegistrationPageForKUKComponent, {
      formType: formType,
      customerUID: customerUID
    })), /*#__PURE__*/React.createElement(Col, {
      xs: 12,
      md: 4,
      lg: 4,
      sm: 12,
      className: formType == 'login' ? "align-self-center" : ""
    }, isLoginView && /*#__PURE__*/React.createElement(LoginActionCardComponent, {
      isBrowserError: this.state.isBrowserError,
      warningMsg: this.state.warningMsg,
      regArray: regArray,
      isSSO: this.state.isSSO,
      theme: theme,
      formType: formType,
      ssoAuthenticationProvider: this?.state?.ssoAuthenticationProvider,
      ssoOnlyLogin: ssoOnlyLogin,
      showQrLoginLink: webQrLoginEnabled,
      onQrLoginClick: this.openInlineQrPanel,
      FooterComponent: formType == 'applicantReg-steps' && /*#__PURE__*/React.createElement(Button, {
        className: "text-white",
        variant: "link",
        onClick: this.toggleLoginAndRegistraionPage
      }, "To Register Click Here.")
    }), !isLoginView && formType == 'applicantReg' && /*#__PURE__*/React.createElement(RegistrationActionCardComponent, {
      formType: formType,
      customerUID: customerUID,
      FooterComponent: /*#__PURE__*/React.createElement(Button, {
        variant: "link",
        onClick: this.toggleLoginAndRegistraionPage
      }, "If you are already registered. Click here.")
    }), !isLoginView && formType == 'applicantRegKuk' && /*#__PURE__*/React.createElement(RegistrationPageForKUKComponent, {
      formType: formType,
      customerUID: customerUID,
      FooterComponent: /*#__PURE__*/React.createElement(Button, {
        variant: "link",
        onClick: this.toggleLoginAndRegistraionPage
      }, "If you are already registered. Click here.")
    })))), /*#__PURE__*/React.createElement(Footer, {
      footerArray: footerArr
    })));
  }
}
class LoginPageApp extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return /*#__PURE__*/React.createElement(ErrorBoundary, null, /*#__PURE__*/React.createElement(LoginPageComponent, this.props));
  }
}
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      hasError: false,
      error: undefined
    };
  }
  static getDerivedStateFromError(error) {
    // Update state so the next render will show the fallback UI.

    return {
      hasError: true,
      error: error
    };
  }
  componentDidCatch(error, errorInfo) {
    // You can also log the error to an error reporting service    
    console.log("test", error, errorInfo);
    try {
      // You can see error logs on http://juno.org.in/customApi/react-logs.html
      //http://juno.org.in/customApi/reactErrorLogging.php
      //https://juno.org.in/customApi/exceptions/currentExceptionGroups.php
      if ('LOCAL_SERVER' != window.juno.serverHelper) {
        $.ajax({
          url: 'https://juno.org.in/customApi/exceptions/exceptionCatcher.php',
          type: 'POST',
          data: {
            EXCEPTION_TYPE: 'REACT_JS',
            STACKTRACE: error.stack,
            CUSTOMER: window.juno.serverHelper,
            SERVER: window.juno.serverHelper,
            PRODUCTION_TEST_FLAG: window.juno.isDebug ? 'TEST' : 'PROD',
            APPLICATION_VERSION: 'REACT',
            CUSTOM_ONE: window.location.href,
            CUSTOM_STACKTRACE: window.location.href + '<br/>' + error + '<br/>' + error.stack
          }
        });
      }
    } catch (e) {
      console.log(e);
    }
  }
  render() {
    if (this.state.hasError) {
      // You can render any custom fallback UI      
      return /*#__PURE__*/React.createElement(Alert, {
        variant: "danger"
      }, /*#__PURE__*/React.createElement(Alert.Heading, {
        as: "h5"
      }, /*#__PURE__*/React.createElement("i", {
        className: "fa fa-exclamation-triangle"
      }), " Error 500 : Something went wrong!"), /*#__PURE__*/React.createElement("hr", null), /*#__PURE__*/React.createElement("p", null, this.state.error + ''));
    }
    return this.props.children;
  }
}

/*$(document).ready(function(){
	ReactDOM.render(React.createElement(App, null), document.getElementById('loginPageDiv'));
});*/

export default LoginPageApp;
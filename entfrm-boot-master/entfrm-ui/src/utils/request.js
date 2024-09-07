import axios from 'axios'
import NProgress from 'nprogress'
import {MessageBox, Message} from 'element-ui'
import store from '@/store'
import errorCode from '@/utils/errorCode'
import {getToken} from '@/utils/auth'
import {tansParams} from '@/utils/entfrm'

axios.defaults.headers['Content-Type'] = 'application/json;charset=utf-8'
axios.defaults.validateStatus = function (status) {
  return status >= 200 && status <= 500 // 默认的
}
// 创建axios实例
const service = axios.create({
  // axios中请求配置有baseURL选项，表示请求URL公共部分
  baseURL: process.env.VUE_APP_BASE_API,
  // 超时
  timeout: 300000
})

NProgress.configure({
  showSpinner: false
})
// request拦截器
service.interceptors.request.use(
  config => {
    NProgress.start()
    const isToken = (config.headers || {}).isToken === false;
    let token = getToken();
    if (token && !isToken) {
      config.headers['satoken'] = token // token
    }
    // headers中配置serialize为true开启序列化
    if (config.method === 'post' && config.headers.serialize) {
      config.data = serialize(config.data);
      //delete config.data.serialize;
    }
    if (config.method === 'get' && config.params) {
      let url = config.url + '?' + tansParams(config.params);
      url = url.slice(0, -1);
      config.params = {};
      config.url = url;
    }
    return config
  },
  error => {
    Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(res => {
    NProgress.done()
    //console.log(JSON.stringify(res))
    const status = Number(res.status) || 200
    const message = errorCode[status] || res.data.msg || errorCode['default']
    if (status === 401) {
      MessageBox.confirm(
        message,
        '系统提示',
        {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).then(() => {
        store.dispatch('LogOut').then(() => {
          location.href = '/index';
        })
      })
    } else if (status === 500) {
      Message({
        message: message,
        type: 'error'
      })
      return Promise.reject(new Error(message))
    } else if (status !== 200 || res.data.code === 1) {
      Message({
        message: message,
        type: 'error'
      })
      return Promise.reject(new Error(message))
    } else {
      return res.data
    }
  },
  error => {
    NProgress.done()
    let {msg} = error;
    if (msg == "Network Error") {
      msg = "后端接口连接异常";
    } else if (msg.includes("timeout")) {
      msg = "系统接口请求超时";
    } else if (msg.includes("Request failed with status code")) {
      msg = "系统接口" + msg.substr(msg.length - 3) + "异常";
    }
    Message({
      message: msg,
      type: 'error',
      duration: 5 * 1000
    })
    return Promise.reject(new Error(error))
  }
)

export default service

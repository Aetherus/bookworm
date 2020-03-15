import axios from 'axios';

const instance = axios.create();

instance.defaults.baseURL = process.env.VUE_APP_API_BASE_URL;

instance.interceptors.request.use(function(config) {
  config.headers['Authorization'] = window.localStorage.getItem('accessToken');
  return config;
});

export default instance;

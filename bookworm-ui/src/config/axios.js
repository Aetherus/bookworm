import axios from 'axios';
import store from '@/store';

const instance = axios.create();

instance.defaults.baseURL = process.env.VUE_APP_API_BASE_URL;

instance.interceptors.request.use(function(config) {
  config.headers['Authorization'] = store.getters.accessToken;
  return config;
});

export default instance;

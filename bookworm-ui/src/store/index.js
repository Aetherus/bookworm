import Vue from 'vue'
import Vuex from 'vuex'
import axios from '@/config/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    librarian: JSON.parse(window.localStorage.getItem('librarian')),
    accessToken: window.localStorage.getItem('accessToken')
  },
  getters: {
    librarian: ({librarian}) => librarian,
    accessToken: ({accessToken}) => accessToken
  },
  mutations: {
    setAccessToken(state, accessToken) {
      state.accessToken = accessToken;
      window.localStorage.setItem('accessToken', accessToken);
    },
    setLibrarian(state, librarian) {
      state.librarian = librarian;
      window.localStorage.setItem('librarian', JSON.stringify(librarian));
    },
    removeAccessToken(state) {
      state.accessToken = null;
      window.localStorage.removeItem('accessToken');
    },
    removeLibrarian(state) {
      state.librarian = null,
        window.localStorage.removeItem('librarian');
    }
  },
  actions: {
    login({commit}, params) {
      return axios.post('/sessions', params).then(resp => {
        commit('setAccessToken', resp.data.accessToken);
        commit('setLibrarian', resp.data.librarian);
      })
    },
    logout({commit}) {
      return new Promise(resolve => {
        commit('removeLibrarian');
        commit('removeAccessToken');
        resolve(null);
      });
    }
  },
  modules: {
  }
})

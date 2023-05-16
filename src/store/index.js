import { createStore } from 'vuex'

export default createStore({
  state () {
    return {
      showSideBar : false,
      upcomingRun: '4 July 2023',
    }
  },
  getters: {
  },
  mutations: {
    toggleSideBar(state) {
      state.showSideBar = !state.showSideBar;
    }
  },
  actions: {
  },
  modules: {
  }
})

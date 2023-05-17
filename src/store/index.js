import { createStore } from 'vuex'
export default createStore({
  state () {
    return {
      showSideBar : false,
      upcomingRun: '4 July 2023',
      navLinks: {'HOME' : '/',
      'THE STORY' : '/story',
      'THE TEAMS' : '/teams',
      'OUR SOCIALS' : '/socials',
      'JOIN SMU-X!' : '/',
      'SCOREBOARD' : '/scoreboard',
      'YOUR TEAM' : '/yourteam'},
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

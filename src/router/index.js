import { createRouter, createWebHashHistory } from 'vue-router'
import LandingPage from '../views/LandingPage.vue'
import GameMaster from '../views/GameMaster.vue'
import ScoreBoard from '../views/ScoreBoard.vue'
import TheTeams from '../views/TheTeams.vue'
import YourTeam from '../views/YourTeam.vue'
import test from '../components/tabManager.vue'


const routes = [
  {
    path: '/',
    name: 'landingPage',
    component: LandingPage,
    meta: {
      scrollToTop: true,
    }
  },
  {
    path: '/gamemaster',
    name: 'gameMaster',
    component: GameMaster,
    meta: {
      requiresAuth: true
    }
  },
  {
    path: '/scoreboard',
    name: 'ScoreBoard',
    component: ScoreBoard
  },
  {
    path: '/theteams',
    name: 'TheTeams',
    component: TheTeams
  },
  {
    path: '/yourteam',
    name: 'YourTeam',
    component: YourTeam
  },
  {
    path: '/test',
    name: 'testing',
    component: test
  }
]



const router = createRouter({
  history: createWebHashHistory(),
  routes
})

// https://bobcares.com/blog/vue-js-authentication-using-vue-router/
// router.beforeEach((to, from, next) => {
//   if (to.matched.some((record) => record.meta.requiresAuth)) {
//     if (localStorage.getItem("jwt") == null) {
//       next({
//         path: "/",
//         params: { nextUrl: to.fullPath },
//       });
//     } else {
//       let user = JSON.parse(localStorage.getItem("user"));
//       if (to.matched.some((record) => record.meta.is_admin)) {
//         if (user.is_admin == 1) {
//           next();
//         } else {
//           next({ name: "userboard" });
//         }
//       } else {
//         next();
//       }
//     }
//   } else if (to.matched.some((record) => record.meta.guest)) {
//     if (localStorage.getItem("jwt") == null) {
//       next();
//     } else {
//       next({ name: "userboard" });
//     }
//   } else {
//     next();
//   }
// });

export default router

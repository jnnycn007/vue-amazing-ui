<script setup lang="ts">
import pkg from '/package.json'
import { ref, computed } from 'vue'
import { routes } from '@/router'
import { useFps } from 'components/utils'
const { fps } = useFps()
const installItems = ref([
  {
    header: 'Install',
    content: `npm install vue-amazing-ui\n# or\npnpm add vue-amazing-ui\n# or\nyarn add vue-amazing-ui\n# or\nbun add vue-amazing-ui`
  }
])
// import.meta.glob 都支持以字符串形式导入文件，类似于 以字符串形式导入资源
const modules = import.meta.glob('../../../package.json', { eager: true })
const url = '../../../package.json'
// 字符串类型对象
type Recordable<T = any> = Record<string, T>
const dependencies = (modules as Recordable)[url].dependencies
const devDependencies = (modules as Recordable)[url].devDependencies
console.log('dependencies', dependencies)
console.log('devDependencies', devDependencies)
const toolFunctions = [
  {
    name: 'dateFormat',
    description: '格式化日期时间字符串函数'
  },
  {
    name: 'formatNumber',
    description: '数字格式化函数'
  },
  {
    name: 'rafTimeout',
    description: '使用 requestAnimationFrame 实现的延迟 setTimeout 或间隔 setInterval 调用函数'
  },
  {
    name: 'cancelRaf',
    description: '用于取消 rafTimeout 函数'
  },
  {
    name: 'throttle',
    description: '节流函数'
  },
  {
    name: 'debounce',
    description: '防抖函数'
  },
  {
    name: 'add',
    description: '消除 js 加减精度问题的加法函数'
  },
  {
    name: 'downloadFile',
    description: '下载文件并自定义文件名，未传文件名时，从文件地址中自动提取文件名称'
  },
  {
    name: 'toggleDark',
    description: '一键切换暗黑模式函数'
  },
  {
    name: 'useEventListener',
    description: '使用 Vue 的生命周期钩子添加和移除事件监听器'
  },
  {
    name: 'useMutationObserver',
    description: '使用 MutationObserver 观察 DOM 元素的变化'
  },
  {
    name: 'useScroll',
    description: '实时监测目标元素滚动位置及状态'
  },
  {
    name: 'useFps',
    description: '实时监测浏览器刷新率 FPS'
  },
  {
    name: 'useMediaQuery',
    description: '使用媒体查询来判断当前环境是否符合指定的媒体查询条件'
  },
  {
    name: 'useResizeObserver',
    description: '使用 ResizeObserver 观察 DOM 元素尺寸变化'
  },
  {
    name: 'useSlotsExist',
    description: '监听给定名称或名称数组的插槽是否存在，支持监听单个插槽或一组插槽的存在'
  },
  {
    name: 'useInject',
    description: '使用依赖注入的函数，用于获取颜色调色板和阴影颜色'
  },
  {
    name: 'useOptionsSupported',
    description: '检查浏览器是否支持给定的事件监听器选项'
  }
]
const functionItems = [
  {
    header: '以上工具函数 API 使用时直接引入即可:',
    content: `\<script setup lang="ts">
import {
  dateFormat,
  formatNumber,
  rafTimeout,
  cancelRaf,
  throttle,
  debounce,
  add,
  downloadFile,
  toggleDark,
  useEventListener,
  useMutationObserver,
  useScroll,
  useFps,
  useMediaQuery,
  useResizeObserver,
  useSlotsExist,
  useInject,
  useOptionsSupported
} from 'vue-amazing-ui'
<\/script>`
  }
]
const activeKey = ref(0)
const componentsTotal = computed(() => {
  return (routes[0].children as Array<any>).length - 3
})
function onOpenWindow() {
  // 打开一个新的窗口，并导航到指定的URL
  // let newWindow = window.open() // 在当前浏览器窗口中打开一个空的标签页
  // let newWindow = window.open('http://localhost:9000/backtop') // 在当前浏览器窗口中打开新的标签页
  // let newWindow = window.open('http://localhost:9000/backtop', 'Backtop') // 在当前浏览器窗口中打开新的标签页
  // 使用弹窗形式打开新的标签页，不指定 left，top 时，默认紧靠电脑桌面左上角
  let newWindow = window.open('http://localhost:9000/backtop', '_blank', 'popup,width=800,height=600')
  // newWindow?.resizeTo(800, 600)
  // newWindow?.moveTo(100, 100)
}
</script>
<template>
  <div>
    <Space gap="small">
      <h1>Vue Amazing UI</h1>
      <Tag color="#FC5404">{{ pkg.version }}</Tag>
    </Space>
    <br />
    <br />
    <Tag color="purple">FPS：{{ fps }}</Tag>
    <br />
    <br />
    <Button type="primary" @click="onOpenWindow">Open New Window</Button>
    <p class="u-tip mt30 mb10"
      >组件库采用 <Tag color="magenta">Vue@{{ devDependencies['vue'] }}</Tag> +
      <Tag color="magenta">TypeScript@{{ devDependencies['typescript'] }}</Tag> +
      <Tag color="magenta">Vite@{{ devDependencies['vite'] }}</Tag> +
      <Tag color="magenta">Less@{{ devDependencies['less'] }}</Tag> 实现！</p
    >
    <p class="u-tip mb10">
      目前共包含
      <Tag color="magenta">{{ componentsTotal }}</Tag>
      个基础
      <Tag color="magenta">UI</Tag>
      组件以及
      <Tag color="magenta">{{ toolFunctions.length }}</Tag>
      个工具函数，并且持续探索更新中...
    </p>
    <p class="u-tip mb10"> 顺便一提，它们全都可以 <Tag color="magenta">treeshaking</Tag> </p>
    <p class="u-tip mb10"> 主题可调，你只需提供一个主题色，剩下的都交给我 </p>
    <p class="u-tip mb10">
      <Tag color="magenta">Vue Amazing UI</Tag> 全量使用 <Tag color="magenta">TypeScript</Tag> 编写，和你的
      <Tag color="magenta">TypeScript</Tag> 项目无缝衔接
    </p>
    <p class="u-tip mb10"> 全部组件均采用单文件组件 <Tag color="magenta">SFC</Tag>，可独立使用 </p>
    <p class="u-tip"> 开箱即用，不墨迹 </p>
    <h2 class="mt30 mb10">使用方式：</h2>
    <Collapse lang="bash" :fontSize="16" :items="installItems" v-model:activeKey="activeKey" copyable />
    <ul class="m-list">
      <li class="u-tip mb10 mt10">全局引入注册所有组件</li>
      <li class="u-tip mb10 mt10">全局引入注册部分组件</li>
      <li class="u-tip mb10 mt10">局部引入注册部分组件</li>
      <li class="u-tip mb10">无需任何安装引入注册，直接使用单文件组件 <Tag color="magenta">SFC</Tag></li>
    </ul>
    <h2 class="mt30">常用工具函数：</h2>
    <ul class="m-list">
      <li class="u-tip mb10" :class="{ mt10: index === 0 }" v-for="(func, index) in toolFunctions" :key="index">
        <Tag color="geekblue">{{ func.name }}</Tag>
        : {{ func.description }}
      </li>
    </ul>
    <Collapse lang="vue" :fontSize="16" :items="functionItems" v-model:activeKey="activeKey" copyable />
    <Descriptions class="mb10 mt30" title="生产环境依赖 (dependencies)" :column="{ md: 2, lg: 3, xl: 4 }">
      <DescriptionsItem :label="dependency" v-for="(version, dependency) in pkg.dependencies" :key="dependency">
        <Tag color="volcano">{{ version }}</Tag>
      </DescriptionsItem>
    </Descriptions>
    <Descriptions class="mb10 mt30" title="开发环境依赖 (devDependencies)" :column="{ md: 2, lg: 3, xl: 4 }">
      <DescriptionsItem :label="dependency" v-for="(version, dependency) in pkg.devDependencies" :key="dependency">
        <Tag color="cyan">{{ version }}</Tag>
      </DescriptionsItem>
    </Descriptions>
  </div>
</template>

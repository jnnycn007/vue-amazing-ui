<script setup lang="ts">
import { h, ref } from 'vue'
import { DoubleLeftOutlined, VerticalAlignTopOutlined, ArrowUpOutlined } from '@ant-design/icons-vue'
const defaultCustomStyle = {
  '--backtop-width': '54px',
  '--backtop-height': '54px',
  '--backtop-icon-size': '32px',
  '--backtop-default-color-hover': '#d4380d'
}
const primaryCustomStyle = {
  '--backtop-width': '54px',
  '--backtop-height': '54px',
  '--backtop-icon-size': '32px',
  '--backtop-primary-bg-color': '#d4380d',
  '--backtop-primary-bg-color-hover': '#dd6747',
  '--backtop-primary-shadow-color': 'rgba(221, 103, 71, 0.36)',
  '--backtop-primary-shadow-color-hover': 'rgba(221, 103, 71, 0.36)',
  '--backtop-square-border-radius': '18px'
}
const primaryDescCustomStyle = {
  '--backtop-width': '54px',
  '--backtop-height': '54px',
  '--backtop-icon-with-desc-size': '30px',
  '--backtop-desc-font-size': '16px',
  '--backtop-primary-bg-color': '#d4380d',
  '--backtop-primary-bg-color-hover': '#dd6747',
  '--backtop-primary-shadow-color': 'rgba(221, 103, 71, 0.36)',
  '--backtop-primary-shadow-color-hover': 'rgba(221, 103, 71, 0.36)',
  '--backtop-square-border-radius': '18px'
}
const scrollContainer = ref()
function onShow(show: boolean) {
  console.log('show', show)
}
</script>
<template>
  <div>
    <h1>{{ $route.name }} {{ $route.meta.title }}</h1>
    <h2 class="mt30 mb10">基本使用</h2>
    <h3 class="mb10">BackTop 会找到首个可滚动的祖先元素并且监听它的滚动事件</h3>
    <BackTop @show="onShow" />
    <h2 class="mt30 mb10">自定义图标</h2>
    <BackTop :right="100" :icon="() => h(VerticalAlignTopOutlined)" />
    <BackTop :right="160">
      <template #icon>
        <DoubleLeftOutlined :rotate="90" />
      </template>
    </BackTop>
    <BackTop :right="220">
      <template #icon>
        <ArrowUpOutlined />
      </template>
    </BackTop>
    <h2 class="mt30 mb10">自定义类型和形状</h2>
    <BackTop shape="square" :right="100" :bottom="100" />
    <BackTop shape="square" description="顶部" :right="160" :bottom="100" />
    <BackTop type="primary" :right="220" :bottom="100" />
    <BackTop type="primary" shape="square" :right="280" :bottom="100" />
    <BackTop type="primary" shape="square" description="顶部" :right="340" :bottom="100" />
    <h2 class="mt30 mb10">文字描述</h2>
    <BackTop description="顶部" :right="100" :bottom="160" />
    <h2 class="mt30 mb10">悬浮提示</h2>
    <BackTop tooltip="回到顶部" :right="160" :bottom="160" />
    <BackTop
      type="primary"
      shape="square"
      tooltip="回到顶部"
      :tooltip-props="{
        bgColor: '#fff',
        tooltipStyle: {
          padding: '8px 12px',
          borderRadius: '12px',
          fontSize: '16px',
          color: 'rgba(0, 0, 0, 0.88)',
          fontWeight: 500
        }
      }"
      :right="220"
      :bottom="160"
    />
    <h2 class="mt30 mb10">自定义样式</h2>
    <BackTop :style="defaultCustomStyle" :right="280" :bottom="160" />
    <BackTop :style="primaryCustomStyle" type="primary" shape="square" :right="350" :bottom="160" />
    <BackTop
      :style="primaryDescCustomStyle"
      type="primary"
      shape="square"
      description="顶部"
      :right="420"
      :bottom="160"
    />
    <h2 class="mt30 mb10">自定义可视高度</h2>
    <h3 class="mb10">自定义滚动时触发显示回到顶部的高度</h3>
    <BackTop :bottom="280" :visibility-height="300">
      <div style="width: 200px; height: 40px; line-height: 40px; text-align: center; font-size: 14px">
        可视高度：300px
      </div>
    </BackTop>
    <h2 class="mt30 mb10">自定义位置</h2>
    <BackTop :right="260" :bottom="280">
      <div style="width: 200px; height: 40px; line-height: 40px; text-align: center; font-size: 14px">改变位置</div>
    </BackTop>
    <h2 class="mt30 mb10">自定义监听目标</h2>
    <h3 class="mb10">自定义设定监听哪个元素来触发 BackTop</h3>
    <BackTop :listen-to="scrollContainer" :bottom="340" :visibility-height="10">
      <div style="width: 200px; height: 40px; line-height: 40px; text-align: center; font-size: 14px"> 指定目标 </div>
    </BackTop>
    <div ref="scrollContainer" style="width: 600px; overflow: auto; height: 100px; line-height: 1.57">
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
      这块应该写一个有意思的笑话。<br />
    </div>
    <br />
    <h3 class="mb10">自动监听 Scrollbar 来触发 BackTop</h3>
    <Scrollbar style="width: 600px; height: 100px">
      <BackTop :bottom="340" :right="260" :visibility-height="10">
        <div style="width: 200px; height: 40px; line-height: 40px; text-align: center; font-size: 14px">
          监听 Scrollbar
        </div>
      </BackTop>
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
      这块应该写一个有意思的笑话。
      <br />
    </Scrollbar>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
const value1 = ref(100000000.12345)
const value2 = ref(100000000)
const animationRef = ref()
const from = ref(0)
const to = ref(100000000)
function onPlay() {
  if (value1.value || value2.value) {
    value1.value = 0
    value2.value = 0
  } else {
    value1.value = 100000000.12345
    value2.value = 100000000
  }
}
function onClick() {
  animationRef.value.play()
}
function onStarted() {
  console.log('started')
}
function onFinished() {
  console.log('finished')
  ;[from.value, to.value] = [to.value, from.value]
}
</script>
<template>
  <div>
    <h1>{{ $route.name }} {{ $route.meta.title }}</h1>
    <br />
    <br />
    <Button type="primary" @click="onPlay">Play</Button>
    <h2 class="mt30 mb10">基本使用</h2>
    <Statistic title="一个小目标">
      <NumberAnimation :to="value1" />
    </Statistic>
    <h2 class="mt30 mb10">精度</h2>
    <Row>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation :from="0.0" :to="value1" :precision="2" />
        </Statistic>
      </Col>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation :to="value1" :precision="3" />
        </Statistic>
      </Col>
    </Row>
    <h2 class="mt30 mb10">自定义前缀 & 后缀</h2>
    <Row>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation prefix="$" :from="0" :to="value2" />
        </Statistic>
      </Col>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation :from="0" :to="value2" suffix="元" />
        </Statistic>
      </Col>
    </Row>
    <h2 class="mt30 mb10">自定义千分位分隔符 & 小数点字符</h2>
    <Row>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation separator=";" decimal="," :precision="2" :from="0" :to="value2" />
        </Statistic>
      </Col>
      <Col :span="12">
        <Statistic title="一个小目标">
          <NumberAnimation separator="" :from="0" :to="value2" />
        </Statistic>
      </Col>
    </Row>
    <h2 class="mt30 mb10">自定义样式</h2>
    <Statistic title="一个小目标">
      <NumberAnimation :value-style="{ fontSize: '30px', fontWeight: 600, color: '#ff6900' }" :from="0" :to="value2" />
    </Statistic>
    <h2 class="mt30 mb10">自定义播放和动画时间</h2>
    <Space vertical>
      <Button type="primary" @click="onClick">播放</Button>
      <Statistic title="一个小目标">
        <NumberAnimation
          ref="animationRef"
          :from="from"
          :to="to"
          :duration="5000"
          :precision="2"
          :autoplay="false"
          @started="onStarted"
          @finished="onFinished"
        />
      </Statistic>
    </Space>
    <h2 class="mt30 mb10">自定义动画过渡效果</h2>
    <Statistic title="一个小目标">
      <NumberAnimation transition="easeInCubic" :from="0" :to="value2" />
    </Statistic>
  </div>
</template>

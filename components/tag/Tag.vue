<script setup lang="ts">
import { ref, computed, nextTick, watchEffect } from 'vue'
import Space from 'components/space'
import { useSlotsExist } from 'components/utils'
export interface Item {
  label?: string // 标签文本 string | slot
  closable?: boolean // 标签是否可以关闭，默认 true
  color?: string // 标签颜色
  icon?: string // 设置图标 string | slot
  size?: 'small' | 'middle' | 'large' // 标签尺寸
  bordered?: boolean // 是否有边框，默认 true
}
export interface Props {
  closable?: boolean // 标签是否可以关闭
  color?: string // 标签颜色
  icon?: string // 设置图标 string | slot
  size?: 'small' | 'middle' | 'large' // 标签尺寸
  bordered?: boolean // 是否有边框
  dynamic?: boolean // 是否启用标签动态添加和删除
  spaceProps?: object // Space 组件属性配置，仅当 dynamic: true 时生效
  value?: string[] | Item[] // 动态标签数组，仅当 dynamic: true 时生效
}
const props = withDefaults(defineProps<Props>(), {
  closable: false,
  color: undefined,
  icon: undefined,
  size: 'middle',
  bordered: true,
  dynamic: false,
  spaceProps: () => ({}),
  value: () => []
})
const inputRef = ref()
const showInput = ref(false)
const inputValue = ref('')
const presetColor = [
  'success',
  'processing',
  'error',
  'warning',
  'default',
  'pink',
  'red',
  'yellow',
  'orange',
  'cyan',
  'green',
  'blue',
  'purple',
  'geekblue',
  'magenta',
  'volcano',
  'gold',
  'lime'
]
const hidden = ref(false)
const tagsIconRef = ref()
const showTagsIcon = ref(Array(props.value.length).fill(1))
const slotsExist = useSlotsExist(['icon'])
const emits = defineEmits(['update:value', 'close', 'dynamicClose'])
const isStrArray = computed(() => {
  if (props.dynamic) {
    if (props.value.length) {
      if (typeof props.value[0] === 'string') {
        return true
      }
      if (typeof props.value[0] === 'object') {
        return false
      }
    }
  }
  return null
})
const tagItems = computed(() => {
  if (props.dynamic) {
    if (props.value.length) {
      if (isStrArray.value) {
        return props.value.map((tag: any) => {
          return {
            label: tag,
            closable: true
          }
        })
      } else {
        return props.value.map((tag: any) => {
          return {
            closable: true,
            ...tag
          }
        })
      }
    }
  }
  return []
})
const showIcon = computed(() => {
  if (!props.dynamic) {
    return slotsExist.icon || props.icon
  }
  return false
})
watchEffect(() => {
  if (props.dynamic) {
    const len = props.value.length
    showTagsIcon.value = Array(len).fill(1)
    nextTick(() => {
      if (tagsIconRef.value) {
        for (let n = 0; n < len; n++) {
          showTagsIcon.value[n] = tagsIconRef.value[n].offsetWidth
        }
      }
    })
  }
})
function onClose(e: MouseEvent) {
  hidden.value = true
  emits('close', e)
}
function onCloseTags(item: Item, n: number) {
  const newValue = (props.value as any[]).filter((item: any, index: number) => {
    return index !== n
  })
  emits('update:value', newValue)
  emits('dynamicClose', item, n)
}
async function onAdd() {
  showInput.value = true
  await nextTick()
  inputRef.value.focus()
}
function onChange() {
  if (isStrArray.value) {
    emits('update:value', [...props.value, inputValue.value])
  } else {
    emits('update:value', [
      ...props.value,
      {
        label: inputValue.value
      }
    ])
  }
  showInput.value = false
  inputRef.value = ''
}
function onKeyboard(e: KeyboardEvent) {
  if (e.key === 'Enter') {
    inputRef.value.blur()
  }
}
</script>
<template>
  <div
    v-if="!dynamic"
    class="m-tag"
    :class="[
      `tag-${size}`,
      color && presetColor.includes(color) ? `tag-${color}` : '',
      {
        'tag-borderless': !bordered,
        'tag-has-color': color && !presetColor.includes(color),
        'tag-hidden': hidden
      }
    ]"
    :style="`background-color: ${color && !presetColor.includes(color) ? color : ''};`"
  >
    <span v-if="showIcon" class="tag-icon">
      <slot name="icon">{{ icon }}</slot>
    </span>
    <span class="tag-label">
      <slot></slot>
    </span>
    <span v-if="closable" class="tag-close" @click="onClose">
      <svg
        focusable="false"
        class="close-svg"
        data-icon="close"
        width="1em"
        height="1em"
        fill="currentColor"
        aria-hidden="true"
        viewBox="64 64 896 896"
      >
        <path
          d="M563.8 512l262.5-312.9c4.4-5.2.7-13.1-6.1-13.1h-79.8c-4.7 0-9.2 2.1-12.3 5.7L511.6 449.8 295.1 191.7c-3-3.6-7.5-5.7-12.3-5.7H203c-6.8 0-10.5 7.9-6.1 13.1L459.4 512 196.9 824.9A7.95 7.95 0 00203 838h79.8c4.7 0 9.2-2.1 12.3-5.7l216.5-258.1 216.5 258.1c3 3.6 7.5 5.7 12.3 5.7h79.8c6.8 0 10.5-7.9 6.1-13.1L563.8 512z"
        ></path>
      </svg>
    </span>
  </div>
  <Space v-else gap="small" v-bind="spaceProps">
    <div
      class="m-tag"
      :class="[
        `tag-${item.size || size}`,
        (item.color || color) && presetColor.includes(item.color || color) ? `tag-${item.color || color}` : '',
        {
          'tag-borderless': item.bordered !== undefined && !item.bordered,
          'tag-has-color': (item.color || color) && !presetColor.includes(item.color || color)
        }
      ]"
      :style="`background-color: ${(item.color || color) && !presetColor.includes(item.color || color) ? item.color || color : ''};`"
      v-for="(item, index) in tagItems"
      :key="index"
    >
      <span v-if="showTagsIcon[index]" ref="tagsIconRef" class="tag-icon">
        <slot name="icon" :item="item" :icon="icon" :index="index">{{ item.icon }}</slot>
      </span>
      <span class="tag-label">
        <slot name="label" :item="item" :label="item.label" :index="index">{{ item.label }}</slot>
      </span>
      <span v-if="item.closable || closable" class="tag-close" @click="onCloseTags(item, index)">
        <svg
          focusable="false"
          class="close-svg"
          data-icon="close"
          width="1em"
          height="1em"
          fill="currentColor"
          aria-hidden="true"
          viewBox="64 64 896 896"
        >
          <path
            d="M563.8 512l262.5-312.9c4.4-5.2.7-13.1-6.1-13.1h-79.8c-4.7 0-9.2 2.1-12.3 5.7L511.6 449.8 295.1 191.7c-3-3.6-7.5-5.7-12.3-5.7H203c-6.8 0-10.5 7.9-6.1 13.1L459.4 512 196.9 824.9A7.95 7.95 0 00203 838h79.8c4.7 0 9.2-2.1 12.3-5.7l216.5-258.1 216.5 258.1c3 3.6 7.5 5.7 12.3 5.7h79.8c6.8 0 10.5-7.9 6.1-13.1L563.8 512z"
          ></path>
        </svg>
      </span>
    </div>
    <div v-if="!showInput" class="m-tag" :class="[`tag-${size}`, { 'tag-plus': dynamic }]" @click="onAdd">
      <svg
        focusable="false"
        class="plus-svg"
        data-icon="plus"
        width="1em"
        height="1em"
        fill="currentColor"
        aria-hidden="true"
        viewBox="64 64 896 896"
      >
        <path d="M482 152h60q8 0 8 8v704q0 8-8 8h-60q-8 0-8-8V160q0-8 8-8z"></path>
        <path d="M176 474h672q8 0 8 8v60q0 8-8 8H176q-8 0-8-8v-60q0-8 8-8z"></path>
      </svg>
    </div>
    <input
      v-if="showInput"
      ref="inputRef"
      class="tag-input"
      :class="`input-${size}`"
      type="text"
      v-model="inputValue"
      @blur="showInput = false"
      @change="onChange"
      @keydown="onKeyboard"
    />
  </Space>
</template>
<style lang="less" scoped>
.m-tag {
  display: inline-flex;
  align-items: center;
  height: 24px;
  font-size: 14px;
  color: rgba(0, 0, 0, 0.88);
  padding-inline: 7px;
  white-space: nowrap;
  background: rgba(0, 0, 0, 0.02);
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  transition: all 0.2s;
  text-align: start;
  .tag-icon {
    margin-right: 5px;
    height: 100%;
    display: inline-flex;
    align-items: center;
    :deep(svg) {
      fill: currentColor;
    }
  }
  .tag-label {
    height: 100%;
    display: inline-flex;
    align-items: center;
  }
  .plus-svg {
    display: inline-flex;
    align-items: center;
    font-size: 14px;
    color: rgba(0, 0, 0, 0.88);
    fill: currentColor;
    font-style: normal;
    line-height: 0;
    text-align: center;
    vertical-align: -0.175em;
    transition: color 0.2s;
  }
  .tag-close {
    margin-left: 3px;
    display: inline-flex;
    align-items: center;
    height: 100%;
    vertical-align: top;
    font-style: normal;
    line-height: 0;
    text-align: center;
    cursor: pointer;
    .close-svg {
      display: inline-block;
      font-size: 12px;
      color: rgba(0, 0, 0, 0.45);
      fill: currentColor;
      transition: all 0.2s;
      &:hover {
        color: rgba(0, 0, 0, 0.88);
      }
    }
  }
}
.tag-small {
  height: 22px;
  font-size: 12px;
  line-height: 20px;
  border-radius: 4px;
  .plus-svg {
    font-size: 12px;
  }
  .tag-close {
    font-size: 10px;
  }
}
.tag-large {
  height: 28px;
  line-height: 26px;
  .tag-close {
    font-size: 14px;
    vertical-align: -0.16em;
  }
}
.tag-plus {
  background: rgb(255, 255, 255);
  border-style: dashed;
  padding-inline: 10px;
  text-align: center;
  cursor: pointer;
  &:hover {
    border-color: #1677ff;
    .plus-svg {
      color: #1677ff;
    }
  }
}
.tag-input {
  width: 86px;
  color: rgba(0, 0, 0, 0.88);
  height: 24px;
  font-size: 14px;
  line-height: 22px;
  padding: 0 8px;
  position: relative;
  display: inline-block;
  min-width: 0;
  background-color: #ffffff;
  border: 1px solid #d9d9d9;
  border-radius: 6px;
  outline: none;
  transition: all 0.2s;
  &:focus {
    border-color: #4096ff;
    box-shadow: 0 0 0 2px rgba(5, 145, 255, 0.1);
    border-right-width: 1px;
    outline: 0;
  }
}
.input-small {
  width: 78px;
  height: 22px;
  font-size: 12px;
  line-height: 20px;
  padding: 0 6px;
  border-radius: 4px;
}
.input-large {
  width: 90px;
  height: 28px;
  line-height: 26px;
}
.tag-success {
  color: #52c41a;
  background: #f6ffed;
  border-color: #b7eb8f;
  :deep(svg) {
    color: #52c41a;
    fill: currentColor;
  }
}
.tag-processing {
  color: #1677ff;
  background: #e6f4ff;
  border-color: #91caff;
  :deep(svg) {
    color: #1677ff;
    fill: currentColor;
  }
}
.tag-error {
  color: #ff4d4f;
  background: #fff2f0;
  border-color: #ffccc7;
  :deep(svg) {
    color: #ff4d4f;
    fill: currentColor;
  }
}
.tag-warning {
  color: #faad14;
  background: #fffbe6;
  border-color: #ffe58f;
  :deep(svg) {
    color: #faad14;
    fill: currentColor;
  }
}
.tag-pink {
  color: #c41d7f;
  background: #fff0f6;
  border-color: #ffadd2;
  :deep(svg) {
    color: #c41d7f;
    fill: currentColor;
  }
}
.tag-red {
  color: #cf1322;
  background: #fff1f0;
  border-color: #ffa39e;
  :deep(svg) {
    color: #cf1322;
    fill: currentColor;
  }
}
.tag-yellow {
  color: #d4b106;
  background: #feffe6;
  border-color: #fffb8f;
  :deep(svg) {
    color: #d4b106;
    fill: currentColor;
  }
}
.tag-orange {
  color: #d46b08;
  background: #fff7e6;
  border-color: #ffd591;
  :deep(svg) {
    color: #d46b08;
    fill: currentColor;
  }
}
.tag-green {
  color: #389e0d;
  background: #f6ffed;
  border-color: #b7eb8f;
  :deep(svg) {
    color: #389e0d;
    fill: currentColor;
  }
}
.tag-cyan {
  color: #08979c;
  background: #e6fffb;
  border-color: #87e8de;
  :deep(svg) {
    color: #08979c;
    fill: currentColor;
  }
}
.tag-blue {
  color: #0958d9;
  background: #e6f4ff;
  border-color: #91caff;
  :deep(svg) {
    color: #0958d9;
    fill: currentColor;
  }
}
.tag-purple {
  color: #531dab;
  background: #f9f0ff;
  border-color: #d3adf7;
  :deep(svg) {
    color: #531dab;
    fill: currentColor;
  }
}
.tag-geekblue {
  color: #1d39c4;
  background: #f0f5ff;
  border-color: #adc6ff;
  :deep(svg) {
    color: #1d39c4;
    fill: currentColor;
  }
}
.tag-magenta {
  color: #eb2f96;
  background: #fff0f6;
  border-color: #ffadd2;
  :deep(svg) {
    color: #eb2f96;
    fill: currentColor;
  }
}
.tag-volcano {
  color: #d4380d;
  background: #fff2e8;
  border-color: #ffbb96;
  :deep(svg) {
    color: #d4380d;
    fill: currentColor;
  }
}
.tag-gold {
  color: #d48806;
  background: #fffbe6;
  border-color: #ffe58f;
  :deep(svg) {
    color: #d48806;
    fill: currentColor;
  }
}
.tag-lime {
  color: #7cb305;
  background: #fcffe6;
  border-color: #eaff8f;
  :deep(svg) {
    color: #7cb305;
    fill: currentColor;
  }
}
.tag-borderless {
  border-color: transparent;
}
.tag-has-color {
  color: #fff;
  border-color: transparent;
  .tag-close .close-svg {
    color: rgba(255, 255, 255, 0.85);
    &:hover {
      color: rgba(255, 255, 255, 1);
    }
  }
}
.tag-hidden {
  display: none;
}
</style>

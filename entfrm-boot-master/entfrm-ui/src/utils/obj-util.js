export function trimFields(obj) {
  const newObj = deepCopy(obj)
  // 遍历属性，如果是String，那么trim
  const keys = Object.keys(newObj)
  for (let i = 0, len = keys.length; i < len; i++) {
    const key = keys[i]
    const val = newObj[key]
    if (typeof val === 'string') {
      newObj[key] = val.trim()
    } else if (Array.isArray(val) || typeof val === 'object') {
      newObj[key] = trimFields(val)
    } else {
      newObj[key] = val
    }
  }
  return newObj
}

export function delEmptyFields(obj) {
  const newObj = trimFields(obj)
  Object.keys(newObj).forEach(key => {
    if (!newObj[key]) {
      delete newObj[key]
    }
  })
  return newObj
}

export function deepCopy(obj) {
  let isNoVal = true
  for (const key in obj) {
    if (obj[key]) {
      isNoVal = false
    }
  }
  if (isNoVal) {
    return Object.create(null)
  } else {
    return JSON.parse(JSON.stringify(obj))
  }
}

/**
 * 找出变化的是不是相同的属性
 */
export function isChangeSameProp(obj1, obj2, obj3) {
}

export function isBlank(val) {
  return val === undefined || val === null || val === ''
}

export function isNotBlank(val) {
  return !isBlank(val)
}

export function isEmpty(val) {
  return val === undefined || val === null || val === '' || val.trim() === ''
}

export function isNotEmpty(val) {
  return !isEmpty(val)
}

export function idxOf(items, item, key) {
  for (let i = 0; i < items.length; i++) {
    if (items[i][key] === item[key]) {
      return i
    }
  }
  return -1
}

export function getLabelByVal(dict, val, props) {
  if (!val) {
    return ''
  }
  // val = val.trim()
  if (!props) {
    props = { label: 'text', value: 'label' }
  }
  for (let i = 0; i < dict.length; i++) {
    if (dict[i][props.value] === val) {
      return dict[i][props.label]
    }
  }
  return val
}

export function getLabelByValInTree(tree, val, props) {
  if (!val) {
    return ''
  }
  // val = val.trim()
  if (!props) {
    props = { label: 'text', value: 'label' }
  }
  const find = node => {
    if (node[props.value] === val) {
      return node[props.label]
    } else if (node.children && node.children.length) {
      for (let i = 0; i < node.children.length; i++) {
        const result = find(node.children[i], val, props)
        if (result) {
          return result
        }
      }
      return undefined
    } else {
      return undefined
    }
  }
  if (Array.isArray(tree)) {
    for (let i = 0; i < tree.length; i++) {
      const result = find(tree[i], val, props)
      if (result) {
        return result
      }
    }
    return undefined
  } else {
    return find(tree, val, props)
  }
}

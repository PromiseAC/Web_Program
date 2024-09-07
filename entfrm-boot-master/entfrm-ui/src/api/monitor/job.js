import request from '@/utils/request'

// 查询定时任务调度列表
export function listJob(query) {
  return request({
    url: '/quartz/job/list',
    method: 'get',
    params: query
  })
}

// 查询定时任务调度详细
export function getJob(id) {
  return request({
    url: '/quartz/job/' + id,
    method: 'get'
  })
}

// 新增定时任务调度
export function addJob(data) {
  return request({
    url: '/quartz/job',
    method: 'post',
    data: data
  })
}

// 修改定时任务调度
export function updateJob(data) {
  return request({
    url: '/quartz/job',
    method: 'put',
    data: data
  })
}

// 删除定时任务调度
export function delJob(id) {
  return request({
    url: '/quartz/job/' + id,
    method: 'delete'
  })
}

// 任务状态修改
export function changeJobStatus(id, status) {
  const data = {
    id,
    status
  }
  return request({
    url: '/quartz/job/changeStatus',
    method: 'put',
    data: data
  })
}


// 定时任务立即执行一次
export function runJob(id, jobGroup) {
  const data = {
    id,
    jobGroup
  }
  return request({
    url: '/quartz/job/run',
    method: 'put',
    data: data
  })
}

// 导出定时任务信息表
export function exportJob(query) {
  return request({
    url: '/quartz/job/export',
    method: 'get',
    params: query
  })
}

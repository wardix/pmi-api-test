local createAlarm = import 'lib/create.alarm.libsonnet';
local listAlarm = import 'lib/list.alarm.libsonnet';
{
  info: {
    name: 'pmt'
  },
  item: [
    createAlarm,
    listAlarm
  ]
}

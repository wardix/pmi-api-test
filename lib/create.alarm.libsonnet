{
  name: 'create alarm',
  event: [
    {
      listen: 'prerequest',
      script: {
        exec: [
          "const secret = pm.environment.get('clientSecret');",
          "const ticketPrefix = 'nusa';",
          "const date = new Date();",
          "const yyyymmdd = date.getFullYear().toString() +",
          "                 (date.getMonth() + 1).toString().padStart(2, '0') +",
          "                 date.getDate().toString().padStart(2, '0');",
          "const token =  CryptoJS.SHA256(secret + yyyymmdd).toString();",
          "const startTime = Math.floor(date.valueOf()/1000);",
          "const ticketNumber = ticketPrefix + yyyymmdd + '02';",
          "console.log(token);",
          "pm.environment.set('token', token);",
          "pm.environment.set('startTime', startTime);",
          "pm.environment.set('ticketNumber', ticketNumber);",
        ],
        type: 'text/javascript'
      }
    },
    {
      listen: 'test',
      script: {
        exec: [
          "pm.test('check response', function () {",
          "  console.log(pm.response.text());",
          "});"
        ],
        type: 'text/javascript'
      }
    }
  ],
  request: {
    auth: {
      type: 'bearer',
      bearer: [
        {
          key: 'token',
          value: '{{token}}',
          type: 'string'
        }
      ]
    },
    method: 'POST',
    header: [],
    body: {
      mode: 'raw',
      raw: '{"client_id": "{{clientId}}", "ticket_number": "{{ticketNumber}}", "summary": "BLACKOUT", "description": "gangguan masal pada node-1", "affected_node": [{ "id": "node-1", "coordinate": "0, 0" }], "affected_segment": [{ "id": "segment-2", "coordinate_ne": "0, 0", "coordinate_fe": "0, 0" }], "status": "open", "target_to_resolved": 2.5, "start_time": {{startTime}} }',
      options: {
        raw: {
          language: 'json'
        }
      }
    },
    url: {
      host: [
        '{{baseUrl}}'
      ],
      path: [
        'v1/id/fo-alarm'
      ]
    }
  }
}

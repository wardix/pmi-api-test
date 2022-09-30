{
  name: 'get list alarm',
  event: [
    {
      listen: 'prerequest',
      script: {
        exec: [
          "const secret = pm.environment.get('clientSecret');",
          "const date = new Date();",
          "const yyyymmdd = date.getFullYear().toString() +",
          "                 (date.getMonth() + 1).toString().padStart(2, '0') +",
          "                 date.getDate().toString().padStart(2, '0');",
          "const token =  CryptoJS.SHA256(secret + yyyymmdd).toString();",
          "pm.environment.set('token', token);",
          "console.log(token);"
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
    method: 'GET',
    header: [],
    url: {
      host: [
        '{{baseUrl}}'
      ],
      path: [
        'v1/id/fo-alarm/{{clientId}}'
      ],
      query: [
        {
          key: 'page',
          value: '1'
        },
        {
          key: 'limit',
          value: '20'
        }
      ]

    }
  }
}

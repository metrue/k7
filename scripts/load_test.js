import { Rate } from 'k6/metrics'
import { check } from 'k6'
import http from 'k6/http'

export const errorRate = new Rate('errors')

export default function () {
  const res = http.get('https://postman-echo.com/get?message=hello')
  const result = check(res, {
    'status 200': (r) => r.status === 200,
    'body': (r) => {
      return r.json().args.message ==  'hello'
    },
  })
  errorRate.add(!result);
}

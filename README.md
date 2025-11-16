# k3s 설정 값

---
> 운영환경과 개발환경을 실습하기 위해, namespace로 분리 해둠.

- namespace
  - development (개발 환경)
  - backend-was (운영 환경)

# k3s 배포

---

```shell
# development 배포 (개발 환경)
$ helm upgrade --install kotlin-spring-example-dev ./k3s -f k3s/values-dev.yaml -n development

# backend-was 배포 (운영 환경)
$ helm upgrade --install kotlin-spring-example-prod ./k3s -f k3s/values-prod.yaml -n backend-was
```

# k3s 구조

---

> namespace는 완전히 분리된 공간으로 namespace가 다르다면 동일한 servicePort를 사용해도 된다.  
> 라우팅 구분의 기준 = Host 헤더(local.spring, dev.spring, prod.spring)

### development 환경
- namespace: development
- 서비스 포트: 80
- 접근 URL: http://dev.spring

```text
Ingress (80)
 → backend.service.name: kotlin-spring-example-dev-svc
 → backend.service.port.number: 80

Service (81 → targetPort 8090)
 → selector: app=kotlin-spring-example-dev

Deployment
 → Pods Listening: 8090
```

### Production 환경
- namespace: backend-was
- 서비스 포트: 80
- 접근 URL: http://prod.spring

```text
Ingress (80)
 → backend.service.name: kotlin-spring-example-prod-svc
 → backend.service.port.number: 80

Service (80 → targetPort 8090)
 → selector: app=kotlin-spring-example-prod

Deployment
 → Pods Listening: 8090
```
### Kurly Search_App

![Home](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/4d2d15e2-3326-49d8-add1-e43ed6a304bf)
![SearchBar Focus](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/7e12b8e5-1f5d-4fe8-b5f0-679aaa3ca401)
![Result TableView](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/ac6f8c3b-9bfa-4fc9-91aa-27c661c3cc4e)
![ActivityIndicator](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/19fa96c9-3c18-4541-a1f7-6177ca27c180)
![Result TableView2](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/28da597d-9f69-4058-85de-8fcea20eb098)
![History SearchTerm](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/d6df6a2a-4d8e-49d7-919e-3401862c546d)
![History SearchTerm Tapped](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/65487373-0576-4801-b767-e781d2c39bed)
![allDelete](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/d38b42a2-a391-4a2a-bca2-80da42bb56de)


- GitHub Search API를 이용한 Repository 검색 앱

***

### 프로젝트 빌드 방법

1. **pod install**
2. 

### 아키텍처

> **클린 아키텍처**

- Data Layer : 백엔드 or 로컬 데이터로부터 데이터를 가져오는 책임을 갖습니다.
- Domain Layer : 앱의 비즈니스 로직을 담당합니다.
- Presentaion Layer : UI 로직 관련 책임을 갖습니다. MVVM 패턴을 활용했습니다.

***

### 사용 라이브러리
- **SnapKit** : Layout 
- **RxSwift / RxDataSources / RxCocoa** : 비동기 처리
- **Kingfisher** : 이미지 처리

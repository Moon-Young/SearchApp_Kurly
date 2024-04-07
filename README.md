### Kurly Search_App



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

# KakaoHairshop_iOS_KimMoonyoung

## 목차 
- [요약](#요약)
- [구현 결과](#구현-결과)
- [개선 및 기능 추가](#개선-및-기능-추가)
- [트러블 슈팅](#트러블-슈팅)
- [학습한 내용](#학습한-내용)


## 요약


-------------
![Search](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/19a00381-a376-43b0-8d81-3e427b656136)
![recentSearchTerm](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/526ead06-805b-4416-9bb0-68974b45f6c9)
![History delete_alldelete](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/8ac89866-47ba-4a04-bbf0-0944e3c44223)






# 구현 결과

(*시뮬레이터로 기록하여 조금의 딜레이가 있습니다.*)
|홈(2열)|홈(3열)|홈(GIF 정지)|
|:----:|:----:|:----:|
|<img src="[https://user-images.githubusercontent.com/29904301/204109475-3d181279-c068-4fd9-9b15-e01bb20accf9.gif](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/19a00381-a376-43b0-8d81-3e427b656136)" width="300">
|<img src="[https://user-images.githubusercontent.com/29904301/204109288-7400be70-b821-4b3e-9300-592bca7481a7.gif](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/526ead06-805b-4416-9bb0-68974b45f6c9)" width="300">
|<img src="[https://user-images.githubusercontent.com/29904301/204109569-b0bb907b-08c4-4fed-a805-5245682d71ce.gif](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/8ac89866-47ba-4a04-bbf0-0944e3c44223)" width="300">
|검색(2열)|검색(3열)|검색(빈 텍스트)|
|<img src="https://user-images.githubusercontent.com/29904301/204109598-83dd555b-2016-4ffd-9c8a-254b5dbec7f2.gif" width="300">
|<img src="https://user-images.githubusercontent.com/29904301/204109592-4684f495-8f94-43e1-ba37-3fc149e96510.gif" width="300">
|<img src="https://user-images.githubusercontent.com/29904301/204109599-4693453b-37ce-4fb1-8bdd-0f31534a2825.gif" width="300">|
|실험실(2개 옵션 기능)|실험실(페이징)||
|<img src="https://user-images.githubusercontent.com/29904301/204109633-c0edf54a-a6ab-4f24-ac36-4996278e1958.gif" width="300">
|<img src="https://user-images.githubusercontent.com/29904301/204109635-8c8e4f23-e022-4641-99cf-a41c54cb5251.gif" width="300">| |

![Home](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/8a910330-fa18-46ad-b79b-b4c3825956f5)
![SearchBar Focus](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/7e12b8e5-1f5d-4fe8-b5f0-679aaa3ca401)
![Result TableView](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/ac6f8c3b-9bfa-4fc9-91aa-27c661c3cc4e)
![ActivityIndicator](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/19fa96c9-3c18-4541-a1f7-6177ca27c180)
![Result TableView2](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/28da597d-9f69-4058-85de-8fcea20eb098)
![History SearchTerm](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/d6df6a2a-4d8e-49d7-919e-3401862c546d)
![History SearchTerm Tapped](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/65487373-0576-4801-b767-e781d2c39bed)
![allDelete](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/d38b42a2-a391-4a2a-bca2-80da42bb56de)




Notion

### Kurly Search_App
- GitHub Search API를 이용한 Repository 검색 앱
***
### 프로젝트 빌드 방법
**pod install**
*****************
### 아키텍처

> **클린 아키텍처**
- Data Layer : 백엔드 or 로컬 데이터로부터 데이터를 가져오는 책임을 갖습니다. DTO, Repository
- Domain Layer : 앱의 비즈니스 로직을 담당합니다. UseCase(Service)
- Presentaion Layer : UI 로직 관련 책임을 갖습니다. MVVM 패턴을 활용했습니다.
*****************
Repository는 서버로 부터 온 Entity를 Service에게 리턴해주는 역할
- Repository → (Entity) → Service → 

Service는 Entity받아서 **Logic**에서 쓸 수있는 Model로 바꿔주는 역할(**핵심 비즈니스 로직**)
- (Entity) → Service → (Model) → 

ViewModel은 Model을 받아서 View에서 쓸수 있게 ViewModel로 바꿔주는 역할
- (Model) → ViewModel → (ViewModel) → View 
  
**View는 ViewModel만 바라보면 됨, 가장 중요한건 모든 방향성 일관적**
  
***

### 사용 라이브러리
**Framework**: UIKit, RxSwift \
**Architecture**: Clean Architecture\
**Design Pattern**: MVVM\
**Branch Model**: GitHub-Flow(master-feature)\
**Library:** RxCocoa, RxRelay, SnapKit, Then, KingFisher, Realm
******************
- SnapKit : Layout 
- RxSwift/RxCocoa : 비동기 처리
- Kingfisher : 이미지 처리
- Realm : 영속 데이터 저장
***

## 요약
### 검색 화면
- [ ]  검색어 입력 후, 검색 결과를 보여 줍니다.
- [ ]  검색어가 비어있을 시, 최근 검색어를 최대 10개까지 보여 줍니다.
- [ ]  최근 검색어는 날짜기준으로 내림차순 정렬합니다.
- [ ]  최근 검색어 ‘삭제’ 또는 ‘전체삭제’가 가능합니다.
- [ ]  최근 검색 내역은 앱 재시작 시에도 유지됩니다.
- [ ]  최근 검색어 선택 시, 검색 결과를 보여줍니다.
- [ ]  검색어 입력 시, 자동완성을 보여줍니다.
- [ ]  자동완성 노출 시, 검색 날짜를 같이 보여줍니다.
- [ ]  자동완성은 최근 검색어에서 추출하여 사용합니다.

### 검색 결과 화면
- [ ]  검색 결과를 List 형태로 보여줍니다.
- [ ]  총 검색 결과 수를 보여줍니다.
- [ ]  저장소 정보를 보여줍니다.
- [ ]  검색 결과 선택 시, WebView 를 통해 저장소로 이동합니다.
- [ ]  Scroll 중간에 Next Page를 미리 호출합니다.
- [ ]  Next Page를 로딩할 때, 로딩 상태를 보여줍니다.
- https://api.github.com/search/repositories?q={keyword}&page={page} 

## Data
### Entity
**RepositoryResponseDTO**
- **totalCount**
- **RepositoryItemResponseDTO**
  
**RepositoryItemResponseDTO**
- **title :** item.name
- **RepositoryOwnerResponseDTO**
  
**RepositoryOwnerResponseDTO**
- **Thumbnail :** owner.avatar_url
- **Description :** owner.login
- **URL** : owner.url
***

# 구현 결과
![Search](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/cebe6881-301a-4a40-b33e-9e63f9648c1b)
![recentSearchTerm](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/4af7b6d3-3723-40ef-a6b2-55332dc6a1ef)
![History delete_alldelete](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/b1c5a4b4-01c2-4c6b-b7c5-8f15c26b66c8)
![WebView](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/e3b673fc-d0aa-4c92-b811-9309ed2406d3)
![Simulator Screen Recording - iPhone 15 Pro Max - 2024-04-07 at 18 08 04](https://github.com/Moon-Young/SearchApp_Kurly/assets/29904301/c9fb9dfc-60d2-47b6-bd50-8f8ab6377ab4)

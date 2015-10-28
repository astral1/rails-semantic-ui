Rails Semantic UI
=================

Rails에서 Semantic UI 사용을 편하게 하기 위해 [astral1/rails-webpack](https://github.com/astral1/rails-webpack)에 기반해 만든 Plugin.

Install
-------

### Gem

```
gem install rails-semantic-ui
```

### Bundler

```
gem 'rails-semantic-ui', '~0.2'
```

Usage
-----

### 사전 설정

[rails-webpack](https://github.com/astral1/rails-webpack/blob/develop/README.md)의 기본 설정이 완료되어야 한다. 링크의 설정을 참조하여 설정한다.

### 초기 설정

```
rails generate semantic_ui:install
```

- --skip (-s) - webpack:sync와 의존성 설치작업을 스킵한다. 이 옵션은 `--skip-install`을 포함한다.
- --skip-install (-i) - 의존성 설치작업을 건너뛴다.

### Layout 생성

```
rails generate semantic_ui:layout [NAME]
```

- --force (-f) - 존재하는 레이아웃을 교체하지 않는다. 기본값이 `false`

지정된 이름으로 semantic-ui 기본 layout을 생성한다.

### Limitation

- Template은 [Slim](slim-lang.com)만을 지원한다.

TO DOs
------

- 다양한 템플릿 엔진을 지원한다.(최소한 erb라도)
- view helper에 대한 지원을 추가한다.

License
-------

MIT 라이센스를 따르며, 상세한 사항은 LICENSE 파일 참조

package com.ast.eom.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.util.UrlPathHelper;

import com.ast.eom.interceptor.AdminCheckInterceptor;
import com.ast.eom.interceptor.AuthControllerCheckInterceptor;
import com.ast.eom.interceptor.LoginCheckInterceptor;

@ComponentScan("com.ast.eom")
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

  // multipart/form-data를 처리할 때
  @Bean
  public MultipartResolver multipartResolver() {
    // 스프링 방식으로 파일 업로드를 처리하고 싶다면,
    // 이 메서드를 통해 MultipartResolver 구현체를 생성해야 한다.
    CommonsMultipartResolver mr = new CommonsMultipartResolver();
    // 이 클래스는 apache-fileupload 라이브러리를 사용한다.
    // 따라서 의존 라이브러리에 명시적으로 추가해야 한다.
    mr.setMaxUploadSize(10000000);
    mr.setMaxInMemorySize(2000000);
    mr.setMaxUploadSizePerFile(5000000);
    return mr;
  }

  // 기본 ViewResolver 대체할 때
  @Bean
  public ViewResolver viewResolver() {
    InternalResourceViewResolver vr = new InternalResourceViewResolver("/WEB-INF/jsp/", ".jsp");
    vr.setOrder(2);
    return vr;
  }

  @Bean
  public ViewResolver tilesViewResolver() {
    UrlBasedViewResolver vr = new UrlBasedViewResolver();

    // Tiles 설정에 따라 템플릿을 실행하는 뷰 처리기 등록.
    // => TilesConfigurer 객체를 찾아 설정 정보를 얻는다.
    vr.setViewClass(TilesView.class);

    vr.setOrder(1); // 기존 뷰리졸버 보다 Tiles를 먼저 적용하기
    return vr;
  }

  // Tiles 설정 정보를 다루는 객체
  @Bean
  public TilesConfigurer tilesConfigurer() {
    TilesConfigurer configurer = new TilesConfigurer();
    configurer.setDefinitions("/WEB-INF/defs/tiles.xml");
    return configurer;
  }

  // @MatrixVariable 사용할 때
  @Override
  public void configurePathMatch(PathMatchConfigurer configurer) {
    UrlPathHelper helper = new UrlPathHelper();
    helper.setRemoveSemicolonContent(false);

    configurer.setUrlPathHelper(helper);
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {

    // 비로그인 유저를 걸러내는 인터셉터
    registry.addInterceptor(new LoginCheckInterceptor()).addPathPatterns("/**")
        .excludePathPatterns("/auth/**").excludePathPatterns("/join/**")
        .excludePathPatterns("/loginCheck").excludePathPatterns("/admin/**")
        .excludePathPatterns("/main/**").excludePathPatterns("/message/**");
    
    // 로그인을 하고도 로그인 창으로 가려는 유저를 걸러내는 인터셉터
    registry.addInterceptor(new AuthControllerCheckInterceptor())
      .addPathPatterns("/auth/form");

    // 관리자 이외의 유저의 관리자 페이지 접근을 방지하는 인터셉터
    registry.addInterceptor(new AdminCheckInterceptor())
      .addPathPatterns("/admin/**");
  }
  
}

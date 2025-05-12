package hp.home_protector;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
//@EnableJpaAuditing
public class HomeProtectorApplication {

    public static void main(String[] args) {
        SpringApplication.run(HomeProtectorApplication.class, args);
    }

}

class todo-deploy {

	exec { "Package App" : 

		command => "sh gradlew war",
		cwd 	=> "${todo_app_loc}",
		logoutput => "true",
		creates	=> "${todo_war_loc}",
		require => Common::File_download["Download Tomcat v 7.0.53"]

	}

	apache-tomcat::deploy { "Deploy Todo War":

		war_loc				=> 	"${todo_war_loc}",
		tomcat_root_dir		=>	"${tomcat}",
		war_name			=>	"${todo_war}",
		require				=> 	[ Exec["Package App"], Exec["Start Tomcat"]]

	}


}
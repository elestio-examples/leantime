[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Leantime, verified and packaged by Elestio

[Leantime](https://github.com/Leantime/leantime) is an open source project management system for non-project manager.
We combine strategy, planning and executing while making it easy for everyone on the team to use. It's an alternative to ClickUp, Monday, or Asana. As simple as Trello but as feature rich as Jira.

<img src="https://github.com/elestio-examples/leantime/raw/main/leantime.png" alt="Leantime" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/Leantime">fully managed Leantime</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you are interested in exploring a decentralized and community-oriented approach to online content.

[![deploy](https://github.com/elestio-examples/Leantime/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?soft=Leantime)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/leantime.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:6580`

## Docker-compose

Here are some example snippets to help you get started creating a container.

  version: "3.3"

  services:
    leantime_db:
      image: elestio/mysql:8.0
      restart: always
      env_file: ./.env
      volumes:
        - ./storage/db_data:/var/lib/mysql
      command: --character-set-server=UTF8MB4 --collation-server=UTF8MB4_unicode_ci
      ports:
        - 172.17.0.1:5193:3306

    leantime:
      image: elestio4test/leantime:${SOFTWARE_VERSION_TAG}
      restart: always
      env_file: ./.env
      volumes:
        - ./storage/public_userfiles:/var/www/html/public/userfiles
        - ./storage/userfiles:/var/www/html/userfiles
      ports:
        - "172.17.0.1:41013:80"
      depends_on:
        - leantime_db

    pma:
      image: phpmyadmin
      restart: always
      links:
        - leantime_db:leantime_db
      ports:
        - "172.17.0.1:29477:80"
      environment:
        PMA_HOST: leantime_db
        PMA_PORT: 3306
        PMA_USER: root
        PMA_PASSWORD: ${ADMIN_PASSWORD}
        UPLOAD_LIMIT: 500M
        MYSQL_USERNAME: root
        MYSQL_ROOT_PASSWORD: ${ADMIN_PASSWORD}
      depends_on:
        - leantime_db


### Environment variables

|       Variable       | Value (example) |
| :------------------: | :-------------: |
| SOFTWARE_VERSION_TAG |     latest      |
|  ADMIN_PASSWORD      |    password     |

# Maintenance

## Logging

The Elestio Leantime Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/Leantime/leantime">Leantime Github repository</a>

- <a target="_blank" href="https://docs.leantime.io/#/">Leantime documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/leantime">Elestio/Leantime Github repository</a>

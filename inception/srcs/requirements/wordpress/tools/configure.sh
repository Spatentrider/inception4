#!/bin/sh

# Wait until MariaDB is reachable before proceeding
while ! mariadb -h $MARIADB_HOST -u $MARIADB_USER -p$MARIADB_PASS $MARIADB_DATABASE_NAME --silent; do
	sleep 20
done 

# Change the current directory to the WordPress installation directory
cd /var/www/html

# Check if the wp-config.php file already exists
if [ -f "wp-config.php" ]; then
	echo "Wordpress already configured!"
else
	echo "Configuring Wordpress"

	# Download WordPress core files
	wp core download --allow-root

	# Create a wp-config.php file with provided database configuration
	wp config create \
		--dbname=$MARIADB_DATABASE_NAME \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASS \
		--dbhost=$MARIADB_HOST \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--allow-root

	# Install WordPress with provided setup information
	wp core install \
		--url=$DOMAIN_NAME \
		--title="$WORDPRESS_TITLE" \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASS \
		--admin_email=$WORDPRESS_ADMIN_MAIL \
		--skip-email \
		--allow-root

	# Create a new user with the specified role and credentials
	wp user create \
		$WORDPRESS_USER \
		$WORDPRESS_MAIL \
		--role=author \
		--user_pass=$WORDPRESS_PASS \
		--allow-root
fi

# Start PHP-FPM service in foreground mode
/usr/sbin/php-fpm81 -F

# Homestead Stack

A (work in progress) extension of [Laravel Homestead](http://laravel.com/docs/master/homestead).

## Installation

Create a stack directory anywhere on your system and clone this repository into it, then duplicate the example `Homestead.yaml` file.

```
git clone git@github.com:steveneaston/homestead-stack.git .
cp homestead/Homestead.yaml.example homestead/Homestead.yaml`
```

Create a symlink to the stack script

```
sudo ln -s ./stack.sh /usr/local/bin/stack
```

You should now have access to the stack, run `stack install` to install the package dependencies.

After installation is complete, launch your stack with `stack up`.


## Usage

The `stack` command gives you access to all of the regular `vagrant` commands, with the addition of:

`stack edit` - Edits the `Homestead.yaml` file.

`stack modify` - Opens the `./homestead` directory in Sublime Text to modify script files, aliases etc.

`stack which` - Prints the location of the stack directory.

`stack open` - Opens the stack directory in Finder.


## Additional Commands

> **Note:** The following commands should be run within the vagrant stack (`stack ssh`).

### MySQL Group Settings
```
sudo nano /etc/mysql/my.cnf

# Add the following line under [mysql]:
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

sudo service mysql restart
```

### Install Imagemagick & PHP Imagick
```
sudo apt-get update && sudo apt-get install imagemagick pkg-config libmagickwand-dev libmagickcore-dev
git clone -b phpseven https://github.com/mkoppanen/imagick.git
cd imagick && phpize && ./configure && make && sudo make install
echo "extension=imagick.so" | sudo tee -a /etc/php/7.0/fpm/php.ini
echo "extension=imagick.so" | sudo tee -a /etc/php/7.0/cli/php.ini
sudo service php7.0-fpm restart
```

### Install cachefilesd
_Speeds up nfs performance_

```
sudo apt-get install -y cachefilesd
echo "RUN=yes" | sudo tee /etc/default/cachefilesd
```

### Install wkhtmltopdf & wkhtmltoimage
```
curl -O http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
tar xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
sudo mv ./wkhtmltox/bin/* /usr/local/bin/
```

### Install Mongo
```
# sudo apt-get install libsasl2-dev
# Follow instructions from: https://github.com/mongodb/mongo-php-driver/tree/PHP7
# Do the mongo.so // 20-mongo.ini thing...
```

## Issues

If you run into issues with PHP sessions with `session_start() failed: Permission denied` run the following:

```
sudo chmod o+rw /var/lib/php/sessions
```

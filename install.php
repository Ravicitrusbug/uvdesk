<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" type="text/javascript"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet"></link>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
<style>
/* Absolute Center Spinner */
.loading {
  position: fixed;
  z-index: 999;
  height: 2em;
  width: 2em;
  overflow: show;
  margin: auto;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
}

/* Transparent Overlay */
.loading:before {
  content: '';
  display: block;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
    background: radial-gradient(rgba(20, 20, 20,.8), rgba(0, 0, 0, .8));

  background: -webkit-radial-gradient(rgba(20, 20, 20,.8), rgba(0, 0, 0,.8));
}

/* :not(:required) hides these rules from IE9 and below */
.loading:not(:required) {
  /* hide "loading..." text */
  font: 0/0 a;
  color: transparent;
  text-shadow: none;
  background-color: transparent;
  border: 0;
}

.loading:not(:required):after {
  content: '';
  display: block;
  font-size: 10px;
  width: 1em;
  height: 1em;
  margin-top: -0.5em;
  -webkit-animation: spinner 150ms infinite linear;
  -moz-animation: spinner 150ms infinite linear;
  -ms-animation: spinner 150ms infinite linear;
  -o-animation: spinner 150ms infinite linear;
  animation: spinner 150ms infinite linear;
  border-radius: 0.5em;
  -webkit-box-shadow: rgba(255,255,255, 0.75) 1.5em 0 0 0, rgba(255,255,255, 0.75) 1.1em 1.1em 0 0, rgba(255,255,255, 0.75) 0 1.5em 0 0, rgba(255,255,255, 0.75) -1.1em 1.1em 0 0, rgba(255,255,255, 0.75) -1.5em 0 0 0, rgba(255,255,255, 0.75) -1.1em -1.1em 0 0, rgba(255,255,255, 0.75) 0 -1.5em 0 0, rgba(255,255,255, 0.75) 1.1em -1.1em 0 0;
box-shadow: rgba(255,255,255, 0.75) 1.5em 0 0 0, rgba(255,255,255, 0.75) 1.1em 1.1em 0 0, rgba(255,255,255, 0.75) 0 1.5em 0 0, rgba(255,255,255, 0.75) -1.1em 1.1em 0 0, rgba(255,255,255, 0.75) -1.5em 0 0 0, rgba(255,255,255, 0.75) -1.1em -1.1em 0 0, rgba(255,255,255, 0.75) 0 -1.5em 0 0, rgba(255,255,255, 0.75) 1.1em -1.1em 0 0;
}

/* Animation */

@-webkit-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-moz-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@-o-keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes spinner {
  0% {
    -webkit-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -ms-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
</style>
</head>
<body class="container" style="top:100px;position:relative">

<?php
//ini_set('display_errors', 1);
//ini_set('display_startup_errors', 1);
//error_reporting(E_ALL);
$success = '';
$loading = '';
error_reporting(E_ERROR | E_PARSE);
$version = phpversion();
echo '<h2>Prerequisite</h2>';
echo '<p>To start with installtion make sure you have following prerequisite intalled on the machine</p>';
echo '<p><b>PHP version:</b> >= 7.3</p>';
echo '<p><b>Extentions:</b> dom, imap, mailparse, mbstring </p>';
$extention_loaded = get_loaded_extensions();
$target = array('dom', 'mbstring','imap','mailparse');

$all_loaded = '';
if(!in_array('dom',$extention_loaded)){
	echo '<p style="color:red">Extentions dom is missing, please install it first to continue';
	$all_loaded = '0';
}
if(!in_array('mbstring',$extention_loaded)){
	echo '<p style="color:red">Extentions mbstring is missing, please install it first to continue';
	$all_loaded = '0';
}
if(!in_array('imap',$extention_loaded)){
	echo '<p style="color:red">Extentions imap is missing, please install it first to continue';
	$all_loaded = '0';
}
if(!in_array('mailparse',$extention_loaded)){
	echo '<p style="color:red">Extentions mailparse is missing, please install it first to continue';
	$all_loaded = '0';
}
if($version < '7.3'){
	echo '<p style="color:red">Please upgrade your php version to greater then 7.3';
	$all_loaded = '0';
}

if(in_array('dom',$extention_loaded) && in_array('mbstring',$extention_loaded) && in_array('imap',$extention_loaded) && in_array('mailparse',$extention_loaded) && $version > '7.3'){
	$all_loaded = '1';
}
if(isset($_POST['form_submit'])){
	$loading = '1';
	$host = $_POST['host'];
	$username = $_POST['username'];
	$password = $_POST['password'];
	$database = $_POST['database'];
	//$mysqli = new mysqli("localhost","las","s&nn2c*NBCKTv@","las");
	$mysqli = new mysqli($host,$username,$password, $database);
	$filename = 'las.sql';
	if ($mysqli -> connect_errno) {
		?>
		<div class="alert alert-warning alert-dismissible fade show" role="alert">
		  <strong>Error in connection</strong> Please check database connection and try again!!
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		  </button>
		</div>
		<?php
		
		//echo "Failed to connect to MySQL: " . $mysqli -> connect_error;
		//exit();
	} else {
		//read the entire string
		$templine = '';
		// Read in entire file
		$lines = file($filename);
		// Loop through each line
		foreach ($lines as $line)
		{
			// Skip it if it's a comment
			if (substr($line, 0, 2) == '--' || $line == '')
				continue;

			// Add this line to the current segment
			$templine .= $line;
			// If it has a semicolon at the end, it's the end of the query
			if (substr(trim($line), -1, 1) == ';')
			{
				// Perform the query
				mysqli_query($mysqli, $templine) or print('Error performing query \'<strong>' . $templine . '\': ' . mysqli_error() . '<br /><br />');
				// Reset temp variable to empty
				$templine = '';
			}
		}
		
		$str = file_get_contents('.env');
		if($str){
			$database_str = 'DATABASE_NAME';
			$host_str = 'DATABASE_HOST';
			$username_str = 'DATABASE_USERNAME';
			$password_str = 'DATABASE_PASSWORD';

			//replace something in the file string - this is a VERY simple example
			$str = str_replace($database_str, $database,$str);
			$str = str_replace($host_str, $host,$str);
			$str = str_replace($username_str, $username,$str);
			$str = str_replace($password_str, $password,$str);

			//write the entire string
			file_put_contents('.env', $str);
		}
		$loading = '0';
		$success = 'done';
		//echo "Tables imported successfully";
		//echo "<pre>";print_r($_POST);die;
	}
	
}
?>
	<?php if(empty($success)){?>
	<div class="card text-center">
		  <div class="card-header">
			<img src="http://52.237.197.184/rtm/public//assets/website/vuvfkZzchtrbor8t.png">
		  </div>
		  <div class="card-body">
			<h5 class="card-title">Installation RTM</h5>
			<p class="card-text">To continue with installation please enter database details</p>
			<form id="form" method="post" action="">
			  <div class="form-group">
				<input type="text" class="form-control" name="host" required="true" id="host" placeholder="Enter host">
			  </div>
			  <div class="form-group">
				<input type="text" class="form-control" name="username" required="true" id="username" placeholder="Enter username">
			  </div>
			  <div class="form-group">
				<input type="text" class="form-control" name="password" required="true" id="password" placeholder="Enter password">
			  </div>
			  <div class="form-group">
				<input type="text" class="form-control" name="database" required="true" id="database" placeholder="Enter database">
			  </div>
			<?php if($all_loaded == '1'){ ?>
			  <button type="submit" class="btn btn-primary" name="form_submit" <?php echo $loading === '1' ? 'disabled': ''?>>Submit</button>
			  <p><?php echo $loading === '1' ? 'Installation is in progress, please wait till its done !!': ''?></p>
			<?php } ?>
			</form>
		  </div>
		  <div class="card-footer text-muted">
			Powered By RTM
		  </div>
		</div>
	
	<?php } ?>
	<?php
	if(!empty($success)){
		?>
		<div class="card text-center">
		  <div class="card-header">
			<img src="http://52.237.197.184/rtm/public//assets/website/vuvfkZzchtrbor8t.png">
		  </div>
		  <div class="card-body">
			<h5 class="card-title">Congratualtions !! Installation done successfully</h5>
			<p class="card-text">Login with the member credential <b>Username:</b> chris@las.com.au <b>Password:</b>  Test@123</p>
			<?php 
			$actual_link = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
			$actual_link = str_replace('/install.php', '', $actual_link);
			?>
			<a target="_blank" href="<?php echo $actual_link; ?>/public/en" class="btn btn-primary">Customer Portal</a> 
			<a target="_blank" href="<?php echo $actual_link; ?>/public/en/member/login" class="btn btn-primary">Member Portal</a>
		  </div>
		  <div class="card-footer text-muted">
			Powered By RTM
		  </div>
		</div>
		
		<?php } ?>
</body>
</html>
<script  src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.0/jquery.validate.min.js"></script>


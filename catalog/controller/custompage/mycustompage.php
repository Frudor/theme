<?php  
class ControllerCustompageMycustompage extends Controller {
  public function index() {
    // set title of the page
    $this->document->setTitle("My Custom Page");
     
    // define template file
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/custompage/mycustompage.tpl')) {
      $this->template = $this->config->get('config_template') . '/template/custompage/mycustompage.tpl';
    } else {
      $this->template = 'default/template/custompage/mycustompage.tpl';
    }
     
    // define children templates
    $this->children = array(
      'common/column_left',
      'common/column_right',
      'common/content_top',
      'common/content_bottom',
      'common/footer',
      'common/header'
    );
     
    // set data to the variable
    $data['my_custom_text'] = "This is my custom page.";
 
    // call the "View" to render the output
	if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/custompage/mycustompage.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/custompage/mycustompage.tpl', $data);
		} else {
			return $this->load->view('default/template/custompage/mycustompage.tpl', $data);
		}
  }
}
?>
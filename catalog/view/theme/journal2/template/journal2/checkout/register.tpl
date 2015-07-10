<div class="checkout-content">
    <div class="radio">
        <label>
            <input type="radio" name="account" value="register" checked="checked" />
            <?php echo $text_register; ?>
        </label>
    </div>
    <?php if ($allow_guest_checkout) { ?>
        <div class="radio">
            <label>
                <input type="radio" name="account" value="guest" />
                <?php echo $text_guest; ?>
            </label>
        </div>
    <?php } ?>
    <div class="radio">
        <label>
            <input type="radio" name="account" value="login" />
            <?php echo $text_i_am_returning_customer; ?>
        </label>
    </div>
</div>
<div class="checkout-content checkout-register">
    <fieldset id="account">
        <h2 class="secondary-title"><?php echo $text_your_details; ?></h2>

        <div class="form-group" style="display: <?php echo(count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
            <label class="control-label"><?php echo $entry_customer_group; ?></label>
            <?php foreach ($customer_groups as $customer_group) { ?>
                <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                    <div class="radio">
                        <label>
                            <input type="radio" name="customer_group_id"
                                   value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked"/>
                            <?php echo $customer_group['name']; ?></label>
                    </div>
                <?php } else { ?>
                    <div class="radio">
                        <label>
                            <input type="radio" name="customer_group_id"
                                   value="<?php echo $customer_group['customer_group_id']; ?>"/>
                            <?php echo $customer_group['name']; ?></label>
                    </div>
                <?php } ?>
            <?php } ?>
        </div>
        <div class="form-group required">
            <label class="control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
            <input type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>"
                   id="input-payment-firstname" class="form-control"/>
        </div>
        <div class="form-group required">
            <label class="control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
            <input type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>"
                   id="input-payment-lastname" class="form-control"/>
        </div>
        <div class="form-group required">
            <label class="control-label" for="input-payment-email"><?php echo $entry_email; ?></label>
            <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>"
                   id="input-payment-email" class="form-control"/>
        </div>
        <div class="form-group required">
            <label class="control-label" for="input-payment-telephone"><?php echo $entry_telephone; ?></label>
            <input type="text" name="telephone" value="" placeholder="<?php echo $entry_telephone; ?>"
                   id="input-payment-telephone" class="form-control"/>
        </div>
        <div class="form-group">
            <label class="control-label" for="input-payment-fax"><?php echo $entry_fax; ?></label>
            <input type="text" name="fax" value="" placeholder="<?php echo $entry_fax; ?>" id="input-payment-fax"
                   class="form-control"/>
        </div>
        <?php foreach ($custom_fields as $custom_field) { ?>
            <?php if ($custom_field['location'] == 'account') { ?>
                <?php if ($custom_field['type'] == 'select') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                        <select
                            name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                            id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                            class="form-control">
                            <option value=""><?php echo $text_select; ?></option>
                            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                <option
                                    value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                            <?php } ?>
                        </select>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'radio') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"><?php echo $custom_field['name']; ?></label>

                        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                <div class="radio">
                                    <label>
                                        <input type="radio"
                                               name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                                               value="<?php echo $custom_field_value['custom_field_value_id']; ?>"/>
                                        <?php echo $custom_field_value['name']; ?></label>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'checkbox') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"><?php echo $custom_field['name']; ?></label>

                        <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                            <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox"
                                               name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]"
                                               value="<?php echo $custom_field_value['custom_field_value_id']; ?>"/>
                                        <?php echo $custom_field_value['name']; ?></label>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'text') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                        <input type="text"
                               name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                               value="<?php echo $custom_field['value']; ?>"
                               placeholder="<?php echo $custom_field['name']; ?>"
                               id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                               class="form-control"/>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'textarea') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                        <textarea
                            name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                            rows="5" placeholder="<?php echo $custom_field['name']; ?>"
                            id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                            class="form-control"><?php echo $custom_field['value']; ?></textarea>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'file') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"><?php echo $custom_field['name']; ?></label>
                        <br/>
                        <button type="button"
                                id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                                data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i
                                class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                        <input type="hidden"
                               name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                               value=""
                               id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"/>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'date') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

                        <div class="input-group date">
                            <input type="text"
                                   name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                                   value="<?php echo $custom_field['value']; ?>"
                                   placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD"
                                   id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                                   class="form-control"/>
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'time') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

                        <div class="input-group time">
                            <input type="text"
                                   name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                                   value="<?php echo $custom_field['value']; ?>"
                                   placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm"
                                   id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                                   class="form-control"/>
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'datetime') { ?>
                    <div id="payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                         class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                        <label class="control-label"
                               for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>

                        <div class="input-group datetime">
                            <input type="text"
                                   name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]"
                                   value="<?php echo $custom_field['value']; ?>"
                                   placeholder="<?php echo $custom_field['name']; ?>"
                                   data-date-format="YYYY-MM-DD HH:mm"
                                   id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"
                                   class="form-control"/>
                            <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                <?php } ?>
            <?php } ?>
        <?php } ?>
    </fieldset>
    <fieldset id="password">
        <h2 class="secondary-title"><?php echo $text_your_password; ?></h2>

        <div class="form-group required">
            <label class="control-label" for="input-payment-password"><?php echo $entry_password; ?></label>
            <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>"
                   id="input-payment-password" class="form-control"/>
        </div>
        <div class="form-group required">
            <label class="control-label" for="input-payment-confirm"><?php echo $entry_confirm; ?></label>
            <input type="password" name="confirm" value="" placeholder="<?php echo $entry_confirm; ?>"
                   id="input-payment-confirm" class="form-control"/>
        </div>
    </fieldset>
    <fieldset id="address">
        <h2 class="secondary-title"><?php echo $text_your_address; ?></h2>
        <?php echo $payment_address; ?>
    </fieldset>
    <?php if ($is_shipping_required): ?>
    <div class="checkbox">
        <label>
            <input type="checkbox" name="shipping_address" value="1" checked="checked" />
            <?php echo $entry_shipping; ?>
        </label>
    </div>
    <fieldset id="shipping-address" style="display: none">
        <h2 class="secondary-title">Shipping Address (not translated)</h2>
        <?php echo $shipping_address; ?>
    </fieldset>
    <?php endif; ?>
</div>
<div class="checkout-content checkout-login">
    <div class="form-group">
        <label class="control-label" for="input-login_email"><?php echo $entry_email; ?></label>
        <input type="text" name="login_email" value="" placeholder="<?php echo $entry_email; ?>" id="input-login_email" class="form-control" />
    </div>
    <div class="form-group">
        <label class="control-label" for="input-login_password"><?php echo $entry_password; ?></label>
        <input type="password" name="login_password" value="" placeholder="<?php echo $entry_password; ?>" id="input-login_password" class="form-control" />
        <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
    </div>
    <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary button" />
</div>
<script>
    $(document).delegate('input[name="shipping_address"]', 'change', function() {
        var $this = $(this);

        if ($this.is(':checked')) {
            $('#shipping-address').hide();
            $this.val(1);
        } else {
            $('#shipping-address').show();
            $this.val(0);
        }
    });
    $(document).delegate('input[name="account"]', 'change', function() {
        if (this.value === 'login') {
            $('.checkout-login').show();
            $('.checkout-register').hide();
        } else {
            $('.checkout-login').hide();
            $('.checkout-register').show();

            if (this.value === 'register') {
                $('#password').show();
            } else {
                $('#password').hide();
            }
        }
    });
</script>
<?php echo $header; ?>
    <style>
        .journal-checkout .left, .journal-checkout .right {
            width: 50%;
            float: left;
        }

        .journal-checkout .checkout-content {
            margin: 10px;
            padding: 10px;
            background: lightblue;
        }

        .checkout-content.checkout-login {
            display: none;
        }

        #payment-confirm-button .buttons {
            /*display: none !important;*/
            cursor: not-allowed !important;
        }

        #payment-confirm-button .buttons .btn {
            pointer-events: none !important;
        }
    </style>
<div id="container" class="container j-container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="checkout <?php echo $class; ?>">
            <h1 class="heading-title"><?php echo $heading_title; ?></h1>
            <?php echo $content_top; ?>

            <div class="journal-checkout">
                <div class="left">
                    <?php if ($is_logged_in): ?>
                        <?php echo $payment_address; ?>
                        <?php if ($is_shipping_required): ?>
                            <?php echo $shipping_address; ?>
                        <?php endif; ?>
                    <?php else: ?>
                        <?php echo $register_form; ?>
                    <?php endif; ?>

                    <?php if ($is_shipping_required): ?>
                        <?php echo $shipping_methods; ?>
                    <?php endif; ?>

                    <?php echo $payment_methods; ?>
                </div>
                <div class="right">
                    <?php echo $cart; ?>
                    <div class="checkout-content">
                        <div class="buttons">
                            <div class="pull-right">
                                <button class="btn button confirm-button">Confirm</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <?php echo $content_bottom; ?></div>
    </div>
</div>
<script>
    $(document).delegate('input[name="shipping_method"]', 'change', function() {
        $(document).trigger('journal_checkout_shipping_changed', this.value);
    });

    $(document).delegate('input[name="payment_method"]', 'change', function() {
        $(document).trigger('journal_checkout_payment_changed', this.value);
    });

    $(document).delegate('.journal-checkout .confirm-button', 'click', function () {
        var data = { };

        $('.journal-checkout input[type="text"], .journal-checkout input[type="password"], .journal-checkout select, .journal-checkout input:checked').each(function () {
            data[$(this).attr('name')] = $(this).val();
        });

        $.ajax({
            url: 'index.php?route=journal2/checkout/confirm',
            type: 'post',
            data: data,
            dataType: 'json',
            beforeSend: function() {
                $('.journal-checkout .confirm-button').button('loading');
            },
            complete: function() {
                $('.journal-checkout .confirm-button').button('reset');
            },
            success: function(json) {
                console.log(json);

                $('.text-danger').remove();
                $('.has-error').removeClass('has-error');

                if (json['errors']) {
                    $.each(json['errors'], function (k, v) {
                        var $element = $('.journal-checkout [name="' + k + '"]');
                        $element.closest('.form-group').addClass('has-error');
                        $element.after('<div class="text-danger">' + v + '</div>');
                    });
                } else {
                    $('#payment-confirm-button input[type="button"]').trigger('click');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_address_changed', function (e, type) {
        var data = { };
        if ($('input[name="' + type + '_address"]:checked').val() === 'existing') {
            data['' + type + '_address_id'] = $('select[name="' + type + '_address_id"]').val();
        } else {
            data['' + type + '_country_id'] = $('select[name="' + type + '_country_id"]').val();
            data['' + type + '_zone_id'] = $('select[name="' + type + '_zone_id"]').val();
        }
        $.ajax({
            url: 'index.php?route=journal2/checkout/save',
            type: 'post',
            data: data,
            dataType: 'json',
            success: function() {
                $(document).trigger('journal_checkout_reload_' + type);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_shipping_changed', function (e, value) {
        $.ajax({
            url: 'index.php?route=journal2/checkout/save',
            type: 'post',
            data: {
                shipping_method: value
            },
            dataType: 'json',
            success: function() {
                $(document).trigger('journal_checkout_reload_cart');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_payment_changed', function (e, value) {
        $.ajax({
            url: 'index.php?route=journal2/checkout/save',
            type: 'post',
            data: {
                payment_method: value
            },
            dataType: 'json',
            success: function() {
                $(document).trigger('journal_checkout_reload_cart');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_reload_shipping', function () {
        $.ajax({
            url: 'index.php?route=journal2/checkout/shipping',
            type: 'get',
            dataType: 'html',
            beforeSend: function() {
                $('.checkout-shipping-methods').css('opacity', 0.5);
            },
            complete: function() {
                $('.checkout-shipping-methods').css('opacity', 1);
            },
            success: function(html) {
                $('.checkout-shipping-methods').replaceWith(html);
                $(document).trigger('journal_checkout_reload_cart');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_reload_payment', function () {
        $.ajax({
            url: 'index.php?route=journal2/checkout/payment',
            type: 'get',
            dataType: 'html',
            beforeSend: function() {
                $('.checkout-payment-methods').css('opacity', 0.5);
            },
            complete: function() {
                $('.checkout-payment-methods').css('opacity', 1);
            },
            success: function(html) {
                $('.checkout-payment-methods').replaceWith(html);
                $(document).trigger('journal_checkout_reload_cart');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $(document).on('journal_checkout_reload_cart', function () {
        $.ajax({
            url: 'index.php?route=journal2/checkout/cart',
            type: 'get',
            dataType: 'html',
            beforeSend: function() {
                $('.checkout-cart').css('opacity', 0.5);
            },
            complete: function() {
                $('.checkout-cart').css('opacity', 1);
            },
            success: function(html) {
                $('.checkout-cart').replaceWith(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
</script>
<?php echo $footer; ?>
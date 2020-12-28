<?php 
  if (isset($_GET['page'])){
    $page = $_GET['page'];
    if ($page < 1)
      $page = 1;
    else if ($page > $n_pages)
      $page = $n_pages;
  }
  else {
    $page = 1;
  }
?>

<div class="pagination">

  <?php if ($page > 1):?>
  <a href="?name=<?php echo $_GET['name']; ?>&page=<?php echo $page - 1; ?>">
    <span class="pagination-text"><i class='fa fa-arrow-circle-left'></i></span> 
  </a>
  <?php endif ?>

  <a>
    <span class="pagination-text"><?php echo $page; ?></span> 
  </a>

  <?php if ($page < $n_pages):?>
  <a href="?name=<?php echo $_GET['name']; ?>&page=<?php echo $page + 1; ?>">
    <span class="profile-text"> <i class='fa fa-arrow-circle-right'></i> </span> 
  </a>
  <?php endif ?>

</div>